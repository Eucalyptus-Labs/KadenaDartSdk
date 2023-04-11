import 'dart:convert';

import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/pact_api/i_pact_api_v1.dart';
import 'package:http/http.dart' as http;

class PactApiV1 extends IPactApiV1 {
  String _nodeUrl = '';
  String? _networkId;

  @override
  Future<void> setNodeUrl({required String nodeUrl}) async {
    // Remove trailing slash if present
    _nodeUrl = nodeUrl.endsWith('/')
        ? nodeUrl.substring(0, nodeUrl.length - 1)
        : nodeUrl;

    // Get the networkId from the node's config
    http.Response response = await http.get(Uri.parse('$_nodeUrl/config'));
    Map<String, dynamic> config = jsonDecode(response.body);
    _networkId = config['chainwebVersion'];

    // return _networkId;
  }

  @override
  String? getNetworkId() {
    return _networkId;
  }

  @override
  Uri buildUrl({
    required String chainId,
    required PactApiV1Endpoints endpoint,
    Map<String, dynamic>? queryParameters,
  }) {
    String url =
        '$_nodeUrl/chainweb/0.0/$_networkId/chain/$chainId/pact/api/v1/${endpoint.name}';
    if (queryParameters != null) {
      url += '?';
      queryParameters.forEach((key, value) {
        url += '$key=$value&';
      });
    }
    return Uri.parse(url);
  }

  @override
  Future<PactResponse> local({
    String? chainId,
    required PactCommand command,
    bool preflight = true,
    bool signatureValidation = true,
    String? host,
  }) async {
    Uri uri = host != null
        ? Uri.parse('$host/local')
        : buildUrl(
            chainId: chainId!,
            endpoint: PactApiV1Endpoints.local,
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
    String? chainId,
    required PactSendRequest commands,
    String? host,
  }) async {
    Uri uri = host != null
        ? Uri.parse('$host/send')
        : buildUrl(
            chainId: chainId!,
            endpoint: PactApiV1Endpoints.send,
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
    String? chainId,
    required PactListenRequest request,
    String? host,
  }) async {
    Uri uri = host != null
        ? Uri.parse('$host/listen')
        : buildUrl(
            chainId: chainId!,
            endpoint: PactApiV1Endpoints.listen,
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
