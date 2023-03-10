import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:kadena_dart_sdk/utils/crypto_lib.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:kadena_dart_sdk/utils/utils.dart';

import 'test_data/test_data.dart';

void main() {
  test('test creation time', () {
    final int creationTime = Utils.getCreationTime();
    // Expect the creation time to be within 10 seconds of now
    expect(
      creationTime >=
          (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).floor() - 10,
      true,
    );
    expect(
      creationTime <=
          (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).floor(),
      true,
    );
  });
}
