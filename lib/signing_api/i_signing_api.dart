import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/models/quicksign_models.dart';

abstract class ISigningApi {
  PactCommandPayload sign({
    required KadenaSignKeyPair keyPair,
    required Map<String, dynamic> request,
  });

  /// Parses the JSON map "request" into a QuicksignRequest object and signs each cmd in the request.
  /// See https://github.com/kadena-io/KIPs/blob/jam/quicksign/kip-0015.md for the Quicksign spec.
  /// This accepts multiple key pairs because the signing wallet might contain multiple keys.
  QuicksignResult quicksign({
    required Map<String, dynamic> request,
    required List<KadenaSignKeyPair> keyPairs,
  });
}
