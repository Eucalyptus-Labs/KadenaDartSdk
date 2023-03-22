import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/models/quicksign_models.dart';
import 'package:kadena_dart_sdk/models/sign_models.dart';

abstract class ISigningApi {
  /// Attempts to parse the JSON map "request" into a SigningRequest object.
  /// Throws errors on failure.
  SignRequest parseSignRequest({
    required Map<String, dynamic> request,
  });

  /// Takes the SignRequest object, and constructs a Pact Command Payload with it
  PactCommandPayload constructPactCommandPayload({
    required SignRequest request,
    required String signingPubKey,
  });

  /// Takes the SigningRequest object, constructs a Pact Payload with it
  /// and signs it with the keyPair.
  SignResult sign({
    required PactCommandPayload payload,
    required KadenaSignKeyPair keyPair,
  });

  /// Attempts to parse the JSON map "request" into a SigningRequest object.
  /// Throws errors on failure.
  /// See https://github.com/kadena-io/KIPs/blob/master/kip-0015.md for the Quicksign spec.
  QuicksignRequest parseQuicksignRequest({
    required Map<String, dynamic> request,
  });

  /// Takes a commandSigData and signs it with the keyPair.
  /// See https://github.com/kadena-io/KIPs/blob/master/kip-0015.md for the CommandSigData spec,
  /// and how you are meant to sign it, and respond to errors while signing.
  QuicksignResponse quicksignSingleCommand({
    required List<KadenaSignKeyPair> keyPairs,
    required CommandSigData commandSigData,
  });

  /// Takes the QuicksignRequest object and signs each cmd in the request.
  /// See https://github.com/kadena-io/KIPs/blob/master/kip-0015.md for the Quicksign spec.
  /// This accepts multiple key pairs because the signing wallet might contain multiple keys.
  QuicksignResult quicksign({
    required List<KadenaSignKeyPair> keyPairs,
    required QuicksignRequest request,
  });
}
