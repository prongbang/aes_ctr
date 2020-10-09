import 'dart:typed_data';

import 'package:aes_ctr/aes_ctr.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('aes_ctr');

  TestWidgetsFlutterBinding.ensureInitialized();

  int counter = 5;
  Uint8List secretKey = Uint8List.fromList([
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ]);

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('encrypt', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'c86232c61a0534857d965c493f0e3a819b';
    });
    var plaintext = "aes ctr - counter";
    expect(await AesCtrCryptography.encrypt(counter, secretKey, plaintext),
        'c86232c61a0534857d965c493f0e3a819b');
  });

  test('decrypt', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'aes ctr - counter';
    });
    var cipher = "c86232c61a0534857d965c493f0e3a819b";
    expect(await AesCtrCryptography.decrypt(counter, secretKey, cipher),
        'aes ctr - counter');
  });
}
