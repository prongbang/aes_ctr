import 'dart:async';
import 'dart:typed_data';

import 'package:aes_ctr/aes_ctr_cryptography.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _plaintext = "aes ctr - counter";
  String _cipher = "";
  String _decrypt = "";

  int counter = 5;
  Uint8List secretKey = Uint8List.fromList(
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);

  @override
  void initState() {
    super.initState();
    initEncryptDecryptState();
  }

  Future<void> initEncryptDecryptState() async {
    var cipher = "";
    var decrypt = "";
    try {
      cipher = await AesCtrCryptography.encrypt(counter, secretKey, _plaintext);
      decrypt = await AesCtrCryptography.decrypt(counter, secretKey, cipher);
      print(cipher);
    } catch (e) {
      print(e);
      decrypt = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _cipher = cipher;
      _decrypt = decrypt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Plaintext: $_plaintext'),
              Text('Cipher: $_cipher'),
              Text('Decrypt: $_decrypt'),
            ],
          ),
        ),
      ),
    );
  }
}
