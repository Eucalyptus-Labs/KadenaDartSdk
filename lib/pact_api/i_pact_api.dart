import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

abstract class IPactApi {
  Future<PactResponse> local({
    required String host,
    required PactCommand command,
    bool preflight = true,
    bool signatureValidation = true,
  });
  Future<PactSendResponse> send({
    required String host,
    required PactSendRequest commands,
  });
  Future<PactResponse> listen({
    required String host,
    required PactListenRequest request,
  });
}
