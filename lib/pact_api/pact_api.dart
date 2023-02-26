import 'dart:convert';

import 'package:kadena_dart_sdk/models/pact_models.dart';
import 'package:kadena_dart_sdk/pact_api/i_pact_api.dart';
import 'package:http/http.dart' as http;

class PactApi extends IPactApi {
  @override
  Future<PactResponse> local({
    required String host,
    required PactCommand command,
    bool preflight = true,
    bool signatureValidation = true,
  }) async {
    http.Response response = await http.post(
      Uri.parse(
        '$host/local?preflight=$preflight&signatureValidation=$signatureValidation',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: command.toJson(),
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
    required String host,
    required PactSendRequest commands,
  }) async {
    http.Response response = await http.post(
      Uri.parse(
        '$host/send',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: commands.toJson(),
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
    required String host,
    required PactListenRequest request,
  }) async {
    http.Response response = await http.post(
      Uri.parse(
        '$host/listen',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: request.toJson(),
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
