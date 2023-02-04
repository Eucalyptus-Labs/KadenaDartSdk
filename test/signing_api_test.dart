import 'package:flutter_test/flutter_test.dart';
import 'package:kadena_dart_sdk/utils/constants.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

import 'test_data/test_data.dart';

void main() {
  ISigningApi signingApi = SigningApi();

  // Create a public/private keypair
  final KadenaSignKeyPair kp = KadenaSignKeyPair(
    publicKey: 'priv_key',
    privateKey: 'pub_key',
  );

// Take the Quicksign Request object as a JSON map
  final Map<String, dynamic> quicksignRequest = {
    "commandSigDatas": [
      {
        "cmd": "Hello, World!",
        "sigs": [
          {
            "pubKey":
                '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51',
          }
        ]
      }
    ]
  };

// Feed the quicksign function with the keypair and quicksign request
  final QuicksignResult result = signingApi.quicksign(
    request: quicksignRequest,
    keyPairs: [kp],
  );

// If you need to send the QuicksignResult across HTTP or Websocket (Like Wallet Connect)
// you can turn it into JSON
  final Map<String, dynamic> resultJson = result.toJson();

  group('quicksign', () {
    test('has correct outcomes', () {
      // Case 1: 1 signature
      QuicksignResult result = signingApi.quicksign(
        request: {
          "commandSigDatas": [commandSigData1],
        },
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
      expect(result.responses![0].commandSigData.sigs[0].sig, expectedSigKp1);

      // Case 2a: 2 required signatures, 1 keypair
      result = signingApi.quicksign(
        request: {
          "commandSigDatas": [commandSigData2],
        },
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
      expect(result.responses![0].commandSigData.sigs[0].sig, expectedSigKp1);
      expect(
        result.responses![0].commandSigData.sigs[1].sig == null,
        true,
      );

      // Case 2b: 2 required signatures, 1 keypair, second sig given
      result = signingApi.quicksign(
        request: {
          "commandSigDatas": [commandSigData2],
        },
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

    test('has fails when expected with proper result', () {
      // Case 1: Parsing failure
      QuicksignResult result = signingApi.quicksign(
        request: {
          "commandSigDatas": [
            {"swag": "swag"}
          ],
        },
        keyPairs: [kp1],
      );
      expect(result.responses == null, true);
      expect(result.error != null, true);
      expect(result.error!.type, QuicksignError.other);
      expect(result.error!.msg != null, true);
      expect(result.error!.msg!, 'Failed to parse quicksign request');

      // Case 2: Signing failure
      // Expect that quicksign with commandSigData fails with quicksign error in response
      // if key is incorrect
      result = signingApi.quicksign(
        request: {
          "commandSigDatas": [commandSigData2],
        },
        keyPairs: [kp3],
      );
      expect(result.responses != null, true);
      expect(result.responses!.length == 2, true);
      expect(result.responses![0].outcome.result, QuicksignOutcome.failure);
      expect(result.responses![0].outcome.msg != null, true);
      expect(
        result.responses![0].outcome.msg!,
        '${Constants.quicksignSignFailure}${kp3.publicKey}',
      );

      // Case 3: Empty list
      result = signingApi.quicksign(
        request: {
          "commandSigDatas": [],
        },
        keyPairs: [kp1],
      );
      expect(result.responses == null, true);
      expect(result.error != null, true);
      expect(result.error!.type, QuicksignError.emptyList);
    });
  });
}
