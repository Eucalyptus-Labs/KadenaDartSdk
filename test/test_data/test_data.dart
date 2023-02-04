import 'package:kadena_dart_sdk/models/pact_models.dart';

const KadenaSignKeyPair kp1 = KadenaSignKeyPair(
  privateKey:
      '1de84cf16631a778317e1c33a6b729875734c129b0094e809713b7225fd3dfb7', // Actual key: 306d157701e3152792133b5db279b50d19e0cd47e9c9bcddb6ea361cfc48d256
  publicKey:
      '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51', // Not the actual public key
);
const KadenaSignKeyPair kp2 = KadenaSignKeyPair(
  privateKey:
      'ceb59748b4de3e69c1e100a62035a6aa5e0126bcae263b71ccf012b30f7f6903',
  publicKey: '370868a06eca9c9fbc06b9b2d882f081ade2caab79667e83e2a94c91973ff5ce',
);
const KadenaSignKeyPair kp3 = KadenaSignKeyPair(
  privateKey: 'failure',
  publicKey: '370868a06eca9c9fbc06b9b2d882f081ade2caab79667e83e2a94c91973ff5ce',
);

// Case 1: 1 signature
final Map<String, dynamic> commandSigData1 = {
  "cmd": "Hello, World!",
  "sigs": [
    {
      "pubKey":
          '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51',
    }
  ]
};

// Case 2: 2 signatures, sign at the same time, sign separately
final Map<String, dynamic> commandSigData2 = {
  "cmd": "Hello, World!",
  "sigs": [
    {
      "pubKey":
          '8d48094ca84b475ece568c4b0d8aacfb1de3278b6bd16b33a60c068b86a2ba51',
    },
    {
      "pubKey":
          '370868a06eca9c9fbc06b9b2d882f081ade2caab79667e83e2a94c91973ff5ce',
    }
  ]
};

// Case 3: Failure
final Map<String, dynamic> commandSigDataFailure = {
  "cmd": "Hello, World!",
  "sigs": [
    {
      "pubKey":
          '370868a06eca9c9fbc06b9b2d882f081ade2caab79667e83e2a94c91973ff5ce',
    },
  ]
};

// Expected values for "Hello, World!"
const String expectedHash = 'URvIHd4RGAg4xWLIK7NfMiP0YGHr3kqVXCez9InPHgM';
const String expectedSigKp1 =
    '756ec1891523f56369c98bf2544a2f91033de9cea53773d7cc4d7812babd9a1d0ab03b706e628bd1636fb5d65083711ba6584bf6ffe471a48657e6a571031306';
const String expectedSigKp2 =
    '0c9ced73f01a9fed72aa2fe1c80c3ab812cc6c179c030f0e965689488d1fb73c8551d72bd44d2e7a986f5268d65aa0d06c19d741f73bbd96de06623b5cc3be0d';
