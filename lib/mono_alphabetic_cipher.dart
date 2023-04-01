import 'package:flutter/material.dart';

class CaesarCipher extends StatefulWidget {
  @override
  _CaesarCipherState createState() => _CaesarCipherState();
}

class _CaesarCipherState extends State<CaesarCipher> {
  final TextEditingController _textEditingController =
  TextEditingController();
  int _shift = 0;
  String _result = "";

  void _encrypt() {
    String input = _textEditingController.text;
    String output = "";
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) {
        output += String.fromCharCode((charCode - 65 + _shift) % 26 + 65);
      } else if (charCode >= 97 && charCode <= 122) {
        output += String.fromCharCode((charCode - 97 + _shift) % 26 + 97);
      } else {
        output += input[i];
      }
    }
    setState(() {
      _result = output;
    });
  }

  void _decrypt() {
    String input = _textEditingController.text;
    String output = "";
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) {
        output += String.fromCharCode((charCode - 65 - _shift) % 26 + 65);
      } else if (charCode >= 97 && charCode <= 122) {
        output += String.fromCharCode((charCode - 97 - _shift) % 26 + 97);
      } else {
        output += input[i];
      }
    }
    setState(() {
      _result = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caesar Cipher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter text to encrypt/decrypt',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter shift value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _shift = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _encrypt,
                  child: Text('Encrypt'),
                ),
                ElevatedButton(
                  onPressed: _decrypt,
                  child: Text('Decrypt'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
