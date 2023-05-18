import 'dart:convert';

import 'package:blake2b/blake2b_hash.dart';
import 'package:hex/hex.dart';
import 'package:pinenacl/ed25519.dart';

class SignAndHash {
  final String hash;
  final String sig;

  SignAndHash({required this.hash, required this.sig});
}

class CryptoLib {
  /// Convert binary hash bytes into a base64url encoded string
  /// with the padding stripped off.
  static String base64UrlBinHash(Uint8List hash) {
    return stripPadding(
      base64Url.encode(hash),
    );
  }

  /// Strips the padding from the base64url encoded string.
  static String stripPadding(String hash) {
    return hash.replaceAll(r'=', '');
  }

  /// Blake hashes the message and returns the raw binary data.
  static Uint8List blakeHashToBinary(String message) {
    return Blake2bHash.hash(
      Uint8List.fromList(message.codeUnits),
      0,
      message.length,
    );
  }

  static String blakeHash(String message) {
    var hash = Blake2bHash.hash(
      Uint8List.fromList(message.codeUnits),
      0,
      message.length,
    );
    return stripPadding(
      base64Url.encode(hash),
    );
  }

  /// Sigsn the hash bytes with the private key
  static String signHashBytes({
    required Uint8List hash,
    required String privateKey,
  }) {
    final SigningKey signingKey = SigningKey.fromSeed(
      HEX.decode(privateKey).toUint8List(),
    );
    var sign = signingKey.sign(hash);
    return HEX.encode(sign.signature);
  }

  /// Decodes the base64 url encoded hash string and signs it with the private key.
  static String signHash({
    required String hash,
    required String privateKey,
  }) {
    return signHashBytes(
      hash: base64Url.decode(base64Url.normalize(hash)),
      privateKey: privateKey,
    );
  }

  /// Hashes the message and signs it with the private key.
  /// Returns the hash and signature.
  static SignAndHash hashAndSign({
    required String message,
    required String privateKey,
  }) {
    final Uint8List hash = blakeHashToBinary(message);
    SigningKey signingKey = SigningKey.fromSeed(
      HEX.decode(privateKey).toUint8List(),
    );
    var sign = signingKey.sign(hash);
    return SignAndHash(
      hash: stripPadding(
        base64Url.encode(hash),
      ),
      sig: HEX.encode(sign.signature),
    );
  }
}
