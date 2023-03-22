import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

enum PactApiV1Endpoints {
  local,
  send,
  listen,
}

abstract class IPactApiV1 {
  /// Set the target node that the API to send requests to.
  /// Example: https://api.chainweb.com
  /// This will fetch the networkId from the node's config and store it for future use.
  Future<void> setNodeUrl({required String nodeUrl});

  /// Build a url for the pact api from the given chainId and endpoint.
  /// Will use the nodeUrl and the networkId set by [setNodeUrl].
  Uri buildUrl({
    required String chainId,
    required PactApiV1Endpoints endpoint,
    Map<String, dynamic>? queryParameters,
  });

  /// Send a local pact command to the node
  /// The [chainId] is the chainId to execute the command on. It is required if [host] is not provided.
  /// The [command] is the pact command to execute dirtily.
  /// The [preflight] is a boolean to enable/disable preflight.
  /// If enabled, the command will be executed in a simulated transaction as close to [send] as possible.
  /// The [signatureValidation] is a boolean to enable/disable signature validation in the local call.
  /// The [host] is the full node url, example: https://api.chainweb.com/chainweb/0.0/testnet01/chain/0/pact/api/v1
  /// If [host] is provided, the [chainId] is not required.
  Future<PactResponse> local({
    String? chainId,
    required PactCommand command,
    bool preflight = true,
    bool signatureValidation = true,
    String? host,
  });

  /// Send a pact command to the node
  /// The [chainId] is the chainId to execute the command on. It is required if [host] is not provided.
  /// The [host] is the full node url, example: https://api.chainweb.com/chainweb/0.0/testnet01/chain/0/pact/api/v1
  /// If [host] is provided, the [chainId] is not required.
  Future<PactSendResponse> send({
    String? chainId,
    required PactSendRequest commands,
    String? host,
  });

  /// Listen for a pact command to be included in a block
  /// This will block until the command has been committed to a block.
  /// The [chainId] is the chainId to execute the command on. It is required if [host] is not provided.
  /// The [host] is the full node url, example: https://api.chainweb.com/chainweb/0.0/testnet01/chain/0/pact/api/v1
  /// If [host] is provided, the [chainId] is not required.
  Future<PactResponse> listen({
    String? chainId,
    required PactListenRequest request,
    String? host,
  });
}
