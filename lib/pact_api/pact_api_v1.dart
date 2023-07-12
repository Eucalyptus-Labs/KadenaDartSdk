import 'dart:convert';

import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/pact_api/i_pact_api_v1.dart';
import 'package:http/http.dart' as http;

class PactApiV1 extends IPactApiV1 {
  String? _nodeUrl;
  String? _networkId;

  @override
  Future<bool> setNodeUrl({
    required String nodeUrl,
    bool queryNetworkId = true,
  }) async {
    // Remove trailing slash if present
    _nodeUrl = nodeUrl.endsWith('/')
        ? nodeUrl.substring(0, nodeUrl.length - 1)
        : nodeUrl;

    if (queryNetworkId) {
      try {
        // Get the networkId from the node's config
        http.Response response = await http.get(Uri.parse('$_nodeUrl/config'));
        Map<String, dynamic> config = jsonDecode(response.body);
        _networkId = config['chainwebVersion'];
      } catch (_) {
        return false;
      }
    }

    return queryNetworkId;
  }

  @override
  String? getNodeUrl() {
    return _nodeUrl;
  }

  @override
  void setNetworkId({required String networkId}) {
    _networkId = networkId;
  }

  @override
  String? getNetworkId() {
    return _networkId;
  }

  @override
  String buildUrl({
    required String chainId,
    String? nodeUrl,
    String? networkId,
  }) {
    return '${nodeUrl ?? _nodeUrl}/chainweb/0.0/${networkId ?? _networkId}/chain/$chainId/pact/api/v1';
  }

  @override
  Uri buildEndpoint({
    required PactApiV1Endpoints endpoint,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
    Map<String, dynamic>? queryParameters,
  }) {
    String path = url ??
        buildUrl(
          chainId: chainId!,
          nodeUrl: nodeUrl,
          networkId: networkId,
        );
    path += '/${endpoint.name}';
    if (queryParameters != null) {
      path += '?';
      queryParameters.forEach((key, value) {
        path += '$key=$value&';
      });
    }
    return Uri.parse(path);
  }

  @override
  Future<PactResponse> local({
    required PactCommand command,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    bool preflight = true,
    bool signatureValidation = true,
    String? url,
  }) async {
    Uri uri = url == null
        ? buildEndpoint(
            endpoint: PactApiV1Endpoints.local,
            chainId: chainId!,
            nodeUrl: nodeUrl,
            networkId: networkId,
            queryParameters: {
              'preflight': preflight,
              'signatureValidation': signatureValidation,
            },
          )
        : buildEndpoint(
            endpoint: PactApiV1Endpoints.local,
            url: url,
            queryParameters: {
              'preflight': preflight,
              'signatureValidation': signatureValidation,
            },
          );
    // print(uri.toString());
    // print('local');
    // print(jsonEncode(command));
    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    try {
      return PactResponse.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } catch (e) {
      throw PactApiError(
        error: response.body,
      );
    }
  }

  @override
  Future<PactSendResponse> send({
    required PactSendRequest commands,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
  }) async {
    Uri uri = url == null
        ? buildEndpoint(
            endpoint: PactApiV1Endpoints.send,
            chainId: chainId!,
            nodeUrl: nodeUrl,
            networkId: networkId,
          )
        : buildEndpoint(
            endpoint: PactApiV1Endpoints.send,
            url: url,
          );
    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commands),
    );

    try {
      return PactSendResponse.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } catch (e) {
      throw PactApiError(
        error: response.body,
      );
    }
  }

  @override
  Future<PactResponse> listen({
    required PactListenRequest request,
    String? chainId,
    String? nodeUrl,
    String? networkId,
    String? url,
  }) async {
    Uri uri = url == null
        ? buildEndpoint(
            endpoint: PactApiV1Endpoints.listen,
            chainId: chainId!,
            nodeUrl: nodeUrl,
            networkId: networkId,
          )
        : buildEndpoint(
            endpoint: PactApiV1Endpoints.listen,
            url: url,
          );

    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request),
    );

    try {
      return PactResponse.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } catch (e) {
      throw PactApiError(
        error: response.body,
      );
    }
  }
}
