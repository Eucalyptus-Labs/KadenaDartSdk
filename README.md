# Overview

This is an SDK in dart for interacting with the Kadena blockchain.

## Sign and Quicksign Usage

```dart
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

// Create a signing API object
ISigningApi signingApi = SigningApi();

// Create a public/private keypair
final KadenaSignKeyPair kp = KadenaSignKeyPair(
  publicKey: 'priv_key',
  privateKey: 'pub_key',
);

// Take the Sign/Quicksign Request object as a JSON map
final Map<String, dynamic> quicksignRequestJson = {
  "commandSigDatas": [
    {
      "cmd": "Hello, World!", // This is not a valid stringified Pact Command Payload, be warned
      "sigs": [
        {
          "pubKey":
              '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51',
        }
      ]
    }
  ]
};
final Map<String, dynamic> signRequestJson = {
  "code": '"Hello"',
  "sender": "sender",
  "networkId": "testnet04",
  "chainId": "1",
  "signingPubKey": '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51',
};

// Parse the requests
final QuicksignRequest quicksignRequest = signingApi.parseQuicksignRequest(
  quicksignRequestJson,
);
final SignRequest signRequest = signingApi.parseSignRequest(
  signRequestJson,
);

// Feed the quicksign function with the keypair and quicksign request
final QuicksignResult quicksignResult = signingApi.quicksign(
  request: quicksignRequest,
  keyPairs: [kp],
);
final SignResult signResult = signingApi.quicksign(
  request: signRequest,
  keyPairs: kp,
);

// If you need to send the QuicksignResult across HTTP or Websocket (Like Wallet Connect)
// you can turn it into JSON
final Map<String, dynamic> quicksignResultJson = quicksignResult.toJson();
final Map<String, dynamic> signResultJson = signResult.toJson();

```

## Implementation

The ISigningApi is an interface so that you can mock it easily, and so that it is possible to create future versions that can easily be replaced with the current implementation.

## Tests

To run the tests:

```bash
flutter test
```

The tests validate the functionality described in the [KIP](https://github.com/kadena-io/KIPs/blob/jam/quicksign/kip-0015.md).
However, the KIP is unmerged, and not finalized, and subject to change.  

## To Do

- Build out the Sign portion of the Signing API
- Build integration tests with an example dApp to prove functionality

## Common Commands

Rebuild the generated code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```