# Overview

This is an SDK in dart for interacting with the Kadena blockchain.

## Sign and Quicksign Usage

### dApp Usage

```dart
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

// Create a signing API object
ISigningApi signingApi = SigningApi();

// Create a sign or quicksign request
SignRequest signRequest = SignRequest(
  code: '"Hello"',
  data: {},
  sender: 'sender',
  networkId: 'testnet04',
  chainId: '1',
  gasLimit: 1000,
  gasPrice: 1e-5,
  signingPubKey: 'pubKey',
  ttl: 600,
  caps: [
    DappCapp(
      role: 'Gas',
      description: 'Gas Cap',
      cap: Capability(
        name: 'Gas',
        args: [
        ],
      ),
    ),
  ],
);

QuicksignRequest quicksignRequest = QuicksignRequest(
  commandSigDatas: [
    CommandSigData(
      cmd: 'Hello, World!', // This is not a valid stringified Pact Command Payload, be warned
      sigs: [
        QuicksignSigner(
          pubKey: 'pubKey',
        ),
      ],
    ),
  ],
);

// You can send the object across a pipe by transforming it into json
final signRequestJson = signRequest.toJson();
final quicksignRequestJson = quicksignRequest.toJson();
```

### Wallet Usage

```dart
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

// Create a signing API object
ISigningApi signingApi = SigningApi();

// Create a public/private keypair
final KadenaSignKeyPair kp = KadenaSignKeyPair(
  publicKey: 'priv_key',
  privateKey: 'pub_key',
);

// Take the Sign/Quicksign Request object received from the dApp
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
  "data": {},
  "sender": "sender",
  "networkId": "testnet04",
  "chainId": "1",
  "gasLimit": 1000,
  "gasPrice": 1e-5,
  "signingPubKey": '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51',
  "ttl": 600,
  "caps": [
    {
      "role": "Gas",
      "description": "Gas Cap",
      "cap": {
        "name": "Gas",
        "args": []
      }
    }
  ]
};

/// Sign Request Flow ///
// 1. Parse the request
final SignRequest signRequest = signingApi.parseSignRequest(
  signRequestJson,
);

// 2. Construct a PactCommandPayload with it
final PactCommandPayload pactCommandPayload = signingApi.constructPactCommandPayload(
  request: signRequest,
);

// 3. Get user's approval to sign the transaction in some way (Alert, Popup, Bottom Sheet etc.)
final bool approval = true;

// 4. Sign the transaction
SignResult signResult
if (approval) {
  signResult = signingApi.sign(
    request: signRequest,
    keyPairs: kp,
  );
}
else {
  signResult = SignResult(
    error: SignRequestError(
      msg: 'User declined to sign',
    ),
  );
}

// 5. Return the sign result to the dApp in JSON format
final Map<String, dynamic> signResultJson = signResult.toJson();

/// Quicksign Flow ///
// 1. Parse the requests
final QuicksignRequest quicksignRequest = signingApi.parseQuicksignRequest(
  quicksignRequestJson,
);

// 2. Store the QuicksignResponses, and loop through each CommandSigData in the QuicksignRequest
final List<QuicksignResponse> quicksignResponseList = [];
for (final CommandSigData commandSigData in quicksignRequest.commandSigDatas) {
  // 3. Get the uer's approval to sign the transaction in some way (Alert, Popup, Bottom Sheet etc.)
  var approval = true;

  // 4. Depending on the approval, sign the transaction or add a noSig QuicksignOutcome
  if (approval) {
    final QuicksignResult quicksignResult = signingApi.quicksignSingleCommand(
      commandSigData: commandSigData,
      keyPairs: kp,
    );
    quicksignResponseList.add(quicksignResult);
  }
  else {
    quicksignResponseList.add(
      QuicksignResponse(
        commandSigData: commandSigData
        outcome: QuicksignOutcome(
          result: QuicksignOutcome.noSig,
        ),
      ),
    );
  }
}

// 5. Return a QuicksignResult to the dApp in JSON format
final QuicksignResult quicksignResult = QuicksignResult(
  responses: quicksignResponseList,
).toJson();
```

## Implementation

The ISigningApi is an interface so that you can mock it easily, and so that it is possible to create future versions that can easily be replaced with the current implementation.

This library is meant to make it easy for dApps to build requests and for wallets to sign them.

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