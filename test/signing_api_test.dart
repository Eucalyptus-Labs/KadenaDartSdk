import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:kadena_dart_sdk/utils/constants.dart';

import 'test_data/test_data.dart';

void main() {
  ISigningApi signingApi = SigningApi();

  group('sign', () {
    test('has correct outcomes', () {
      // Case 1: 1 signature
      for (final request in signingRequests) {
        SignRequest request1 = signingApi.parseSignRequest(
          request: request,
        );
        // print(request1);
        PactCommandPayload pcp = signingApi.constructPactCommandPayload(
          request: request1,
          signingPubKey: kp1.publicKey,
        );
        SignResult result = signingApi.sign(
          payload: pcp,
          keyPair: kp1,
        );
        expect(result.error == null, true);

        PactCommandPayload pactCommand = PactCommandPayload.fromJson(
          jsonDecode(
            result.body!.cmd,
          ),
        );
        expect(pactCommand.payload.exec!.code, request1.code);
        expect(pactCommand.meta.sender, request1.sender);
        expect(pactCommand.networkId, request1.networkId);
        expect(
          CryptoLib.blakeHash(result.body!.cmd),
          result.body!.hash,
        );
        expect(result.body!.sigs.length == 1, true);
        expect(
          CryptoLib.signHash(
            hash: result.body!.hash,
            privateKey: kp1.privateKey,
          ),
          result.body!.sigs[0].sig,
        );

        if (request1.caps != null) {
          // print('request1.caps: ${request1.caps}');
          expect(pactCommand.signers[0].clist != null, true);
          expect(
            pactCommand.signers[0].clist!.length,
            request1.caps!.map((e) => e.cap).toList().length,
          );
        }
      }
    });

    test('has fails when expected with proper result', () {
      // Case 1: Parsing failure
      expect(
        () => signingApi.parseSignRequest(
          request: signingRequestFailureParse,
        ),
        throwsA(
          predicate(
            (e) => e is SignResult && e.error != null && e.error!.msg.contains('{pactCode: "Hello"}'),
          ),
        ),
      );
    });
  });

  group('quicksign', () {
    test('single command has correct outcomes', () {
      // Case 1: 1 signature
      QuicksignRequest quicksignRequest1 = signingApi.parseQuicksignRequest(
        request: commandSigDatas1,
      );
      QuicksignResponse result = signingApi.quicksignSingleCommand(
        commandSigData: quicksignRequest1.commandSigDatas[0],
        keyPairs: [kp1],
      );
      expect(
        result.commandSigData.cmd,
        quicksignRequest1.commandSigDatas[0].cmd,
      );
      expect(result.outcome.hash != null, true);
      expect(result.outcome.hash, expectedHash);
      expect(result.commandSigData.sigs.length == 1, true);
      expect(
        result.commandSigData.sigs[0].sig != null,
        true,
      );
      expect(result.toPactCommand().pactCommand != null, true);
      // expect(result.commandSigData.sigs[0].sig, expectedSigKp1);

      // Case 2a: 2 required signatures, 1 keypair
      QuicksignRequest quicksignRequest2 = signingApi.parseQuicksignRequest(
        request: commandSigDatas2,
      );
      result = signingApi.quicksignSingleCommand(
        commandSigData: quicksignRequest2.commandSigDatas[0],
        keyPairs: [kp1],
      );
      expect(
        result.commandSigData.cmd,
        quicksignRequest1.commandSigDatas[0].cmd,
      );
      expect(result.outcome.hash != null, true);
      expect(result.outcome.hash, expectedHash);
      expect(result.commandSigData.sigs.length == 2, true);
      expect(
        result.commandSigData.sigs[0].sig != null,
        true,
      );
      // expect(result.commandSigData.sigs[0].sig, expectedSigKp1);
      expect(
        result.commandSigData.sigs[1].sig == null,
        true,
      );
      expect(result.toPactCommand().msg, QuicksignResponse.missingSignatures);

      // Case 2b: 2 required signatures, 1 keypair, second sig given
      quicksignRequest2 = signingApi.parseQuicksignRequest(
        request: commandSigDatas2,
      );
      result = signingApi.quicksignSingleCommand(
        commandSigData: quicksignRequest2.commandSigDatas[0],
        keyPairs: [kp2],
      );
      expect(
        result.commandSigData.cmd,
        quicksignRequest1.commandSigDatas[0].cmd,
      );
      expect(result.outcome.hash != null, true);
      expect(result.outcome.hash, expectedHash);
      expect(result.commandSigData.sigs.length == 2, true);
      expect(
        result.commandSigData.sigs[0].sig == null,
        true,
      );
      expect(
        result.commandSigData.sigs[1].sig != null,
        true,
      );
      expect(result.commandSigData.sigs[1].sig, expectedSigKp2);
      // Missing 1 sig, so no pact command
      expect(result.toPactCommand().msg, QuicksignResponse.missingSignatures);
    });

    test('all has correct outcomes', () {
      // Case 1: 1 signature
      QuicksignRequest quicksignRequest1 = signingApi.parseQuicksignRequest(
        request: commandSigDatas1,
      );
      QuicksignResult result = signingApi.quicksign(
        request: quicksignRequest1,
        keyPairs: [kp1],
      );
      expect(result.responses != null, true);
      expect(result.responses!.length == 1, true);
      expect(result.responses![0].outcome.hash != null, true);
      expect(result.responses![0].outcome.hash, expectedHash);
      expect(result.responses![0].commandSigData.sigs.length == 1, true);
      expect(
        result.responses![0].commandSigData.sigs[0].sig != null,
        true,
      );
      // expect(result.responses![0].commandSigData.sigs[0].sig, expectedSigKp1);

      // Case 2a: 2 required signatures, 1 keypair
      QuicksignRequest quicksignRequest2 = signingApi.parseQuicksignRequest(
        request: commandSigDatas2,
      );
      result = signingApi.quicksign(
        request: quicksignRequest2,
        keyPairs: [kp1],
      );
      expect(result.responses != null, true);
      expect(result.responses!.length == 1, true);
      expect(result.responses![0].outcome.hash != null, true);
      expect(result.responses![0].outcome.hash, expectedHash);
      expect(result.responses![0].commandSigData.sigs.length == 2, true);
      expect(
        result.responses![0].commandSigData.sigs[0].sig != null,
        true,
      );
      // expect(result.responses![0].commandSigData.sigs[0].sig, expectedSigKp1);
      expect(
        result.responses![0].commandSigData.sigs[1].sig == null,
        true,
      );

      // Case 2b: 2 required signatures, 1 keypair, second sig given
      quicksignRequest2 = signingApi.parseQuicksignRequest(
        request: commandSigDatas2,
      );
      result = signingApi.quicksign(
        request: quicksignRequest2,
        keyPairs: [kp2],
      );
      expect(result.responses != null, true);
      expect(result.responses!.length == 1, true);
      expect(result.responses![0].outcome.hash != null, true);
      expect(result.responses![0].outcome.hash, expectedHash);
      expect(result.responses![0].commandSigData.sigs.length == 2, true);
      expect(
        result.responses![0].commandSigData.sigs[0].sig == null,
        true,
      );
      expect(
        result.responses![0].commandSigData.sigs[1].sig != null,
        true,
      );
      expect(result.responses![0].commandSigData.sigs[1].sig, expectedSigKp2);
    });

    test('single command fails when expected with proper result', () {
      // Case 1: Signing failure
      // Expect that quicksign with commandSigData fails with quicksign error in response
      // if key is incorrect
      CommandSigData commandSigData = signingApi
          .parseQuicksignRequest(
            request: commandSigDatas2,
          )
          .commandSigDatas[0];
      QuicksignResponse result = signingApi.quicksignSingleCommand(
        commandSigData: commandSigData,
        keyPairs: [kp3],
      );
      expect(result.commandSigData.cmd, commandSigData.cmd);
      expect(result.outcome.result, QuicksignOutcome.failure);
      expect(
        result.outcome.msg,
        '${Constants.quicksignSignFailure}${kp3.publicKey}',
      );
      expect(
        result.toPactCommand().msg,
        '${QuicksignOutcome.failure}: ${Constants.quicksignSignFailure}${kp3.publicKey}',
      );

      // Case 2: No sig
      // Expect that quicksign with commandSigData fails with quicksign error in response
      // if key is incorrect
      commandSigData = signingApi
          .parseQuicksignRequest(
            request: commandSigDatas1,
          )
          .commandSigDatas[0];
      result = signingApi.quicksignSingleCommand(
        commandSigData: commandSigData,
        keyPairs: [kp2],
      );
      expect(result.commandSigData.cmd, commandSigData.cmd);
      expect(result.outcome.result, QuicksignOutcome.noSig);
      expect(
        result.toPactCommand().msg,
        '${QuicksignOutcome.noSig}: null',
      );
    });

    test('all fails when expected with proper result', () {
      // Case 1: Parsing failure
      expect(
        () => signingApi.parseQuicksignRequest(
          request: commandSigDataFailureParse,
        ),
        throwsA(
          predicate(
            (e) =>
                e is QuicksignResult &&
                e.error != null &&
                e.error!.type == QuicksignError.other &&
                e.error!.msg != null &&
                e.error!.msg! == 'Failed to parse quicksign request',
          ),
        ),
      );

      // Case 2: Empty list
      expect(
        () => signingApi.parseQuicksignRequest(
          request: commandSigDataFailureEmptyList,
        ),
        throwsA(
          predicate((e) {
            // print((e as QuicksignResult).error!.type);
            return e is QuicksignResult && e.error != null && e.error!.type == QuicksignError.emptyList;
          }),
        ),
      );

      // Case 3: Signing failure
      // Expect that quicksign with commandSigData fails with quicksign error in response
      // if key is incorrect
      QuicksignResult result = signingApi.quicksign(
        request: signingApi.parseQuicksignRequest(
          request: commandSigDatas2,
        ),
        keyPairs: [kp3],
      );
      expect(result.responses != null, true);
      expect(result.responses!.length, 1);
      expect(result.responses![0].outcome.result, QuicksignOutcome.failure);
      expect(result.responses![0].outcome.msg != null, true);
      expect(
        result.responses![0].outcome.msg!,
        '${Constants.quicksignSignFailure}${kp3.publicKey}',
      );
    });
  });
}
