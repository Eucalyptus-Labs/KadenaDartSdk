import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kadena_dart_sdk/utils/constants.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

import 'test_data/test_data.dart';

void main() {
  ISigningApi signingApi = SigningApi();
  IPactApiV1 pactApi = PactApiV1();

  group('setNodeUrl and buildUrl', () {
    test('have correct outcomes', () async {
      final List<String> urls = [
        nodeUrlTestnet,
        '$nodeUrlTestnet/',
      ];
      for (final String url in urls) {
        await pactApi.setNodeUrl(nodeUrl: url);
        Uri uri = pactApi.buildUrl(
          chainId: '0',
          endpoint: PactApiV1Endpoints.local,
          queryParameters: {
            'preflight': true,
            'signatureValidation': true,
          },
        );
        expect(
          uri.toString(),
          'https://api.testnet.chainweb.com/chainweb/0.0/testnet04/chain/0/pact/api/v1/local?preflight=true&signatureValidation=true&',
        );
      }

      await pactApi.setNodeUrl(nodeUrl: nodeUrlMainnet);

      Uri uri = pactApi.buildUrl(
        chainId: '0',
        endpoint: PactApiV1Endpoints.send,
      );
      expect(
        uri.toString(),
        'https://api.chainweb.com/chainweb/0.0/mainnet01/chain/0/pact/api/v1/send',
      );
    });
  });

  group('local', () {
    test('has correct outcomes', () async {
      // Test signing request with caps
      SignRequest request1 = signingApi.parseSignRequest(
        request: signingRequest1,
      );
      PactCommandPayload pcp = signingApi.constructPactCommandPayload(
        request: request1,
        signingPubKey: kp1.publicKey,
      );
      SignResult result = signingApi.sign(
        payload: pcp,
        keyPair: kp1,
      );

      // Test setNodeUrl
      await pactApi.setNodeUrl(nodeUrl: nodeUrlTestnet);

      PactResponse response = await pactApi.local(
        chainId: '1',
        command: result.body!,
        preflight: false,
      );
      expect(response.result.status, 'success');
      expect(response.result.data, 'Hello');

      // Test signing request without caps
      request1 = signingApi.parseSignRequest(
        request: signingRequest2,
      );
      pcp = signingApi.constructPactCommandPayload(
        request: request1,
        signingPubKey: kp1.publicKey,
      );
      result = signingApi.sign(
        payload: pcp,
        keyPair: kp1,
      );

      response = await pactApi.local(
        chainId: '1',
        command: result.body!,
        preflight: false,
      );
      expect(response.result.status, 'success');
      expect(response.result.data, 'Hello');

      // Test host and preflight
      response = await pactApi.local(
        host:
            'https://api.testnet.chainweb.com/chainweb/0.0/testnet04/chain/1/pact/api/v1',
        command: result.body!,
        preflight: false,
      );
      expect(response.result.status, 'success');
      expect(response.result.data, 'Hello');

      // Test signing request with invalid caps
      try {
        response = await pactApi.local(
          chainId: '1',
          command: result.body!,
        );
      } on PactApiError catch (e) {
        expect(e.error.contains('BuyGasFailure'), true);
      }
    });
  });
}
