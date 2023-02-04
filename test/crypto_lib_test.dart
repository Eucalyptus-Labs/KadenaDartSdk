import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:kadena_dart_sdk/utils/crypto_lib.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

import 'test_data/test_data.dart';

void main() {
  test('test blake hash', () {
    expect(
      CryptoLib.blakeHash(
        'hello',
      ),
      "Mk3PAn3UowqTLEQfNlol6GsXPe-kuOWJSCU0cbgbcs8",
    );
    expect(
      CryptoLib.blakeHashToBinary(
        'hello',
      ),
      [
        50,
        77,
        207,
        2,
        125,
        212,
        163,
        10,
        147,
        44,
        68,
        31,
        54,
        90,
        37,
        232,
        107,
        23,
        61,
        239,
        164,
        184,
        229,
        137,
        72,
        37,
        52,
        113,
        184,
        27,
        114,
        207,
      ],
    );
  });

  test('test sign message', () {
    final String privateKey = kp1.privateKey;
    const String message = "Hello, World!";
    final String hash = CryptoLib.blakeHash(message);
    final Uint8List hashBin = CryptoLib.blakeHashToBinary(message);
    expect(
      expectedSigKp1,
      CryptoLib.signHash(
        hash: hash,
        privateKey: privateKey,
      ),
    );
    expect(
      expectedSigKp1,
      CryptoLib.signHashBytes(
        hash: hashBin,
        privateKey: privateKey,
      ),
    );

    final SignAndHash res = CryptoLib.hashAndSign(
      message: message,
      privateKey: privateKey,
    );
    expect(expectedHash, res.hash);
    expect(expectedSigKp1, res.sig);
  });
}
