import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

/// @codec: https://flutter.dev/docs/development/platform-integration/platform-channels#codec
class AesCtrCryptography {
  static const MethodChannel _channel = const MethodChannel('aes_ctr');

  /// 128-bit = (16 bytes * 8 bits/byte), 192-bit and 256-bit secretKey
  static Future<String> encrypt(
      int counter, Uint8List secretKey, String plaintext) async {
    return await _channel.invokeMethod("encrypt", <String, dynamic>{
      'counter': counter,
      'secretKey': secretKey,
      'plaintext': plaintext
    });
  }

  /// 128-bit = (16 bytes * 8 bits/byte), 192-bit and 256-bit secretKey
  static Future<String> decrypt(
      int counter, Uint8List secretKey, String cipher) async {
    return await _channel.invokeMethod("decrypt", <String, dynamic>{
      'counter': counter,
      'secretKey': secretKey,
      'cipher': cipher
    });
  }
}
