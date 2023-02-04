import 'package:flutter/foundation.dart';
import 'package:kadena_dart_sdk/utils/constants.dart';
import 'package:kadena_dart_sdk/utils/crypto_lib.dart';
import 'package:kadena_dart_sdk/signing_api/i_signing_api.dart';
import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/models/quicksign_models.dart';

class SigningApi extends ISigningApi {
  @override
  PactCommandPayload sign({
    required Map<String, dynamic> request,
    required KadenaSignKeyPair keyPair,
  }) {
    // TODO: implement sign
    throw UnimplementedError();
  }

  @override
  QuicksignResult quicksign({
    required Map<String, dynamic> request,
    required List<KadenaSignKeyPair> keyPairs,
  }) {
    try {
      QuicksignRequest quicksignRequest = QuicksignRequest.fromJson(request);

      // If the request has an empty list of commands, return an error
      if (quicksignRequest.commandSigDatas.isEmpty) {
        return QuicksignResult(
          error: QuicksignError(
            type: QuicksignError.emptyList,
          ),
        );
      }

      List<QuicksignResponse> responses = [];

      // Loop through the list of commands
      for (CommandSigData command in quicksignRequest.commandSigDatas) {
        bool signed = false;
        Uint8List hash = CryptoLib.blakeHashToBinary(command.cmd);

        // Loop through the requests signatures
        for (QuicksignSigner sig in command.sigs) {
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
                final response = QuicksignResponse(
                  commandSigData: command,
                  outcome: QuicksignOutcome(
                    result: QuicksignOutcome.failure,
                    msg:
                        '${Constants.quicksignSignFailure}${keyPair.publicKey}',
                  ),
                );
                responses.add(response);
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
          final response = QuicksignResponse(
            commandSigData: command,
            outcome: outcome,
          );
          responses.add(response);
        } else {
          // If the keypair was not found, no sig!
          final response = QuicksignResponse(
            commandSigData: command,
            outcome: QuicksignOutcome(
              result: QuicksignOutcome.noSig,
            ),
          );
          responses.add(response);
        }
      }

      return QuicksignResult(
        responses: responses,
      );
    } catch (e) {
      return QuicksignResult(
        error: QuicksignError(
          type: QuicksignError.other,
          msg: Constants.quicksignParseFailure,
        ),
      );
    }
  }
}
