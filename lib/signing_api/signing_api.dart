import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kadena_dart_sdk/models/sign_models.dart';
import 'package:kadena_dart_sdk/utils/constants.dart';
import 'package:kadena_dart_sdk/utils/crypto_lib.dart';
import 'package:kadena_dart_sdk/signing_api/i_signing_api.dart';
import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/models/quicksign_models.dart';

import '../utils/utils.dart';

class SigningApi extends ISigningApi {
  @override
  SignRequest parseSignRequest({
    required Map<String, dynamic> request,
  }) {
    try {
      // Parse the request into a SigningRequest object
      return SignRequest.fromJson(request);
    } catch (e) {
      throw SignResult(
        error: SignRequestError(
          msg: '''Could not parse signing request, expected format:
{
	"code": String, // Pact code to be executed
	"data": Object, // Pact environment data
	"sender": String, // An account, the gas payer of the transaction
	"networkId": String, // Network ID: api.chainweb.com
	"chainId": String, // Chain ID: 1, 2, 3... not to be confused with
	"gasLimit": Number, // Gas limit
	"gasPrice": Number, // Gas price
	"signingPubKey": String, // The public key signing the TX
	"ttl": Number, // TX Timeout
	"caps": [DappCapp],
}
Received:
${request.toString()}''',
        ),
      );
    }
  }

  @override
  PactCommandPayload constructPactCommandPayload({
    required SignRequest request,
  }) {
    return PactCommandPayload(
      networkId: request.networkId,
      payload: CommandPayload(
        exec: ExecMessage(
          data: request.data ?? request.envData ?? {},
          code: request.code ?? request.pactCode ?? '',
        ),
      ),
      signers: [
        SignerCapabilities(
          pubKey: request.signingPubKey,
          clist: request.caps.map((e) => e.cap).toList(),
        ),
      ],
      meta: CommandMetadata(
        chainId: request.chainId,
        gasLimit: request.gasLimit,
        gasPrice: request.gasPrice,
        sender: request.sender,
        ttl: request.ttl,
      ),
    );
  }

  @override
  SignResult sign({
    required PactCommandPayload payload,
    required KadenaSignKeyPair keyPair,
  }) {
    try {
      // Double encode it so it gets backslashes,
      // which will be added when you jsonEncode the PactCommand
      final String cmd = jsonEncode(jsonEncode(payload));

      final hashAndSign = CryptoLib.hashAndSign(
        message: cmd,
        privateKey: keyPair.privateKey,
      );

      return SignResult(
        body: PactCommand(
          cmd: jsonEncode(payload),
          hash: hashAndSign.hash,
          sigs: [
            Signer(
              sig: hashAndSign.sig,
            ),
          ],
        ),
      );
    } catch (e) {
      return SignResult(
        error: SignRequestError(
          msg: 'Invalid signing request',
        ),
      );
    }
  }

  @override
  QuicksignRequest parseQuicksignRequest({
    required Map<String, dynamic> request,
  }) {
    QuicksignRequest? quicksignRequest;
    try {
      // If the request is null, try to parse the json request
      quicksignRequest = QuicksignRequest.fromJson(request);
    } catch (e) {
      throw QuicksignResult(
        error: QuicksignError(
          type: QuicksignError.other,
          msg: Constants.quicksignParseFailure,
        ),
      );
    }

    // If the request has an empty list of commands, return an error
    if (quicksignRequest.commandSigDatas.isEmpty) {
      throw QuicksignResult(
        error: QuicksignError(
          type: QuicksignError.emptyList,
        ),
      );
    }

    return quicksignRequest;
  }

  @override
  QuicksignResponse quicksignSingleCommand({
    required List<KadenaSignKeyPair> keyPairs,
    required CommandSigData commandSigData,
  }) {
    bool signed = false;
    Uint8List hash = CryptoLib.blakeHashToBinary(commandSigData.cmd);

    // Loop through the requests signatures
    for (QuicksignSigner sig in commandSigData.sigs) {
      // Loop through the key pairs
      for (KadenaSignKeyPair keyPair in keyPairs) {
        // If the public key matches the key pair public key
        if (sig.pubKey == keyPair.publicKey) {
          try {
            // Sign the hash
            final String signature = CryptoLib.signHashBytes(
              hash: hash,
              privateKey: keyPair.privateKey,
            );

            // Add the signature to the sig object
            sig.sig = signature;
          } catch (e) {
            // If there was an error
            return QuicksignResponse(
              commandSigData: commandSigData,
              outcome: QuicksignOutcome(
                result: QuicksignOutcome.failure,
                msg: '${Constants.quicksignSignFailure}${keyPair.publicKey}',
              ),
            );
          }

          // We have "signed" it even if there is an error
          signed = true;
        }
      }
    }

    if (signed) {
      // Create the outcome object
      final outcome = QuicksignOutcome(
        result: QuicksignOutcome.success,
        hash: CryptoLib.base64UrlBinHash(hash),
      );

      // Create the response object and append it to the responses
      return QuicksignResponse(
        commandSigData: commandSigData,
        outcome: outcome,
      );
    } else {
      // If the keypair was not found, no sig!
      return QuicksignResponse(
        commandSigData: commandSigData,
        outcome: QuicksignOutcome(
          result: QuicksignOutcome.noSig,
        ),
      );
    }
  }

  @override
  QuicksignResult quicksign({
    required QuicksignRequest request,
    required List<KadenaSignKeyPair> keyPairs,
  }) {
    List<QuicksignResponse> responses = [];

    // Loop through the list of commands
    for (CommandSigData command in request.commandSigDatas) {
      responses.add(
        quicksignSingleCommand(
          commandSigData: command,
          keyPairs: keyPairs,
        ),
      );
    }

    return QuicksignResult(
      responses: responses,
    );
  }
}
