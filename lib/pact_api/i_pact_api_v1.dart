import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

enum PactApiV1Endpoints {
  local,
  send,
  listen,
}

abstract class IPactApiV1 {
  /// Set the target node that the API to send requests to.
  /// Example: https://api.chainweb.com
  /// If [queryNetworkId] is true, this will fetch the networkId
  /// from the node's config and store it for future use.
  /// Returns true if it was able to get the networkId from the node.
  Future<bool> setNodeUrl({
    required String nodeUrl,
    bool queryNetworkId = true,
  });

  /// Get the nodeUrl set by [setNodeUrl].
  String? getNodeUrl();

  /// Set the networkId. This is used to build the url for the pact api.
  /// Not necessary if [setNodeUrl] successfully fetched the networkId from the node.
  /// When running in flutter web, [setNodeUrl] with fail due to CORS, and you will
  /// have to manually set the networkId with this funcion.
  void setNetworkId({required String networkId});

  /// Get the networkId of the node set by [setNodeUrl].
  /// Returns null if the nodeUrl has not been set.
  String? getNetworkId();

  /// Build a url for the pact api from the given chainId
  /// Will use the nodeUrl and the networkId set by [setNodeUrl] and/or [setNetworkId]
  /// if [nodeUrl] and [networkId] are not provided.
  String buildUrl({
    required String chainId,
    String? nodeUrl,
    String? networkId,
  });

  Uri buildEndpoint({
    required PactApiV1Endpoints endpoint,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
    Map<String, dynamic>? queryParameters,
  });

  /// Send a local pact command to the node
  /// The [command] is the pact command to execute dirtily.
  /// The [chainId] is the chainId to execute the command on. It is required if [url] is not provided.
  /// The [nodeUrl] and the [networkId] are used to override the defaults set
  /// by [setNodeUrl] and [setNetworkId] when building the url for the pact api.
  /// The [url] is the full node url, example: https://api.chainweb.com/chainweb/0.0/testnet01/chain/0/pact/api/v1
  /// If [url] is provided, the [chainId] is not required.
  /// The [preflight] is a boolean to enable/disable preflight.
  /// If enabled, the command will be executed in a simulated transaction as close to [send] as possible.
  /// The [signatureValidation] is a boolean to enable/disable signature validation in the local call.
  Future<PactResponse> local({
    required PactCommand command,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
    bool preflight = true,
    bool signatureValidation = true,
  });

  /// Send a pact command to the node
  /// The [chainId] is the chainId to execute the command on. It is required if [url] is not provided.
  /// The [nodeUrl] and the [networkId] are used to override the defaults set
  /// by [setNodeUrl] and [setNetworkId] when building the url for the pact api.
  /// The [url] is the full node url, example: https://api.chainweb.com/chainweb/0.0/testnet01/chain/0/pact/api/v1
  /// If [url] is provided, the [chainId] is not required.
  Future<PactSendResponse> send({
    required PactSendRequest commands,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
  });

  /// Listen for a pact command to be included in a block
  /// This will block until the command has been committed to a block.
  /// The [chainId] is the chainId to execute the command on. It is required if [url] is not provided.
  /// The [nodeUrl] and the [networkId] are used to override the defaults set
  /// by [setNodeUrl] and [setNetworkId] when building the url for the pact api.
  /// The [url] is the full node url, example: https://api.chainweb.com/chainweb/0.0/testnet01/chain/0/pact/api/v1
  /// If [url] is provided, the [chainId] is not required.
  Future<PactResponse> listen({
    required PactListenRequest request,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
  });
}
