# aes_ctr

AES CTR - Counter Flutter plugin.

## Usage

```dart
import 'dart:async';
import 'dart:typed_data';
import 'package:aes_ctr/aes_ctr.dart';

void main() async {
    var plaintext = "aes ctr - counter";

    int counter = 5;
    
    // 128-bit = (16 bytes * 8 bits/byte), 192-bit and 256-bit secretKey
    Uint8List secretKey = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    
    var cipher = await AesCtrCryptography.encrypt(counter, secretKey, plaintext);
    var decrypt = await AesCtrCryptography.decrypt(counter, secretKey, cipher);
    print(decrypt);
}
```

