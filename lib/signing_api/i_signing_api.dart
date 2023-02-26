import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/models/quicksign_models.dart';
import 'package:kadena_dart_sdk/models/sign_models.dart';

abstract class ISigningApi {
  /// Attempts to parse the JSON map "request" into a SigningRequest object.
  /// Throws errors on failure.
  SignRequest parseSignRequest({
    required Map<String, dynamic> request,
  });

  /// Takes the SigningRequest object, constructs a Pact Payload with it
  /// and signs it with the keyPair.
  SignResult sign({
    required KadenaSignKeyPair keyPair,
    required SignRequest request,
  });

  /// Attempts to parse the JSON map "request" into a SigningRequest object.
  /// Throws errors on failure.
  /// See https://github.com/kadena-io/KIPs/blob/jam/quicksign/kip-0015.md for the Quicksign spec.
  QuicksignRequest parseQuicksignRequest({
    required Map<String, dynamic> request,
  });

  /// Takes the QuicksignRequest object and signs each cmd in the request.
  /// See https://github.com/kadena-io/KIPs/blob/jam/quicksign/kip-0015.md for the Quicksign spec.
  /// This accepts multiple key pairs because the signing wallet might contain multiple keys.
  QuicksignResult quicksign({
    required List<KadenaSignKeyPair> keyPairs,
    required QuicksignRequest request,
  });
}
