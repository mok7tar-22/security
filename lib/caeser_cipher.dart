
import 'dart:math';

import 'package:flutter/material.dart';

class MonoAlphabeticCipherPage extends StatefulWidget {
  @override
  _MonoAlphabeticCipherPageState createState() =>
      _MonoAlphabeticCipherPageState();
}

class _MonoAlphabeticCipherPageState extends State< MonoAlphabeticCipherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _encrypt(String input, String key) {
    List<String> alphabet = List.generate(26, (int index) => String.fromCharCode(index + 65));
    List<String> shuffledAlphabet = List.from(alphabet)..shuffle(Random(key.hashCode));
    Map<String, String> encryptionMap = Map.fromIterables(alphabet, shuffledAlphabet);
    return input.toUpperCase().split('').map((char) => encryptionMap[char] ?? char).join();
  }

  String _decrypt(String input, String key) {
    List<String> alphabet = List.generate(26, (int index) => String.fromCharCode(index + 65));
    List<String> shuffledAlphabet = List.from(alphabet)..shuffle(Random(key.hashCode));
    Map<String, String> decryptionMap = Map.fromIterables(shuffledAlphabet, alphabet);
    return input.toUpperCase().split('').map((char) => decryptionMap[char] ?? char).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MonoAlphabetic Cipher'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _inputController,
                  decoration: InputDecoration(labelText: 'Input'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _keyController,
                  decoration: InputDecoration(labelText: 'Key'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a key';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Encrypt'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String input = _inputController.text;
                      String key = _keyController.text;
                      String output = _encrypt(input, key);
                      _outputController.text = output;
                    }
                  },
                ),
                ElevatedButton(
                  child: Text('Decrypt'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String input = _inputController.text;
                      String key = _keyController.text;
                      String output = _decrypt(input, key);
                      _outputController.text = output;
                    }
                  },
                ),
                TextFormField(
                  controller: _outputController,
                  decoration: InputDecoration(labelText: 'Output'),
                  readOnly: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}