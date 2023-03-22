import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:kadena_dart_sdk/utils/crypto_lib.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

import 'test_data/test_data.dart';

void main() {
  test('test blake hash', () {
    expect(
      CryptoLib.blakeHash(
          "{\"networkId\":\"mainnet01\",\"payload\":{\"exec\":{\"data\":{},\"code\":\"(free.wiz-arena.make-offer \\\"3066\\\" \\\"k:aa1cd85c7396fbbc28545a148b18bd20aa05138d624ed93401762509b82e0e9c\\\" 11.0)\"}},\"signers\":[{\"pubKey\":\"aa1cd85c7396fbbc28545a148b18bd20aa05138d624ed93401762509b82e0e9c\",\"clist\":[{\"name\":\"free.wiz-arena.ACCOUNT_GUARD\",\"args\":[\"k:aa1cd85c7396fbbc28545a148b18bd20aa05138d624ed93401762509b82e0e9c\"]},{\"name\":\"coin.GAS\",\"args\":[]}]}],\"meta\":{\"chainId\":\"1\",\"gasLimit\":4000,\"gasPrice\":1e-8,\"sender\":\"k:aa1cd85c7396fbbc28545a148b18bd20aa05138d624ed93401762509b82e0e9c\",\"ttl\":600,\"creationTime\":1679344621},\"nonce\":\"2023-03-20T14:37:06.838\"}"),
      'i65yK0yrzwNRPka2GDTbu81JI13LX1V4OEGJg6sCnaQ',
    );
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
    final String privateKey = kpTest.privateKey;
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
