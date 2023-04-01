import 'package:flutter/material.dart';

class PlayfairCipher {
  String _key;
  late List<List<String>> _matrix;

  PlayfairCipher(this._key) {
    _matrix = List.generate(5, (_) => List<String>.filled(5, ''));
    _generateMatrix(_key);
  }

  List<List<String>> _generateMatrix(String key) {
    key = key.toUpperCase().replaceAll('J', 'I');
    List<String> keyChars = key.split('');
    keyChars = keyChars.toSet().toList();
    List<String> alphabet = 'ABCDEFGHIKLMNOPQRSTUVWXYZ'.split('');
    List<String> remainingChars =
    alphabet.where((char) => !keyChars.contains(char)).toList();
    int index = 0;

    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 5; col++) {
        if (index < keyChars.length) {
          _matrix[row][col] = keyChars[index];
        } else {
          _matrix[row][col] = remainingChars[index - keyChars.length];
        }
        index++;
      }
    }
    return _matrix;
  }

  String encrypt(String plaintext) {
    return _processText(plaintext, true);
  }

  String decrypt(String ciphertext) {
    return _processText(ciphertext, false);
  }

  String _processText(String text, bool encrypt) {
    text = text.toUpperCase().replaceAll('J', 'I');
    List<String> pairs = _splitIntoPairs(text);
    String processedText = '';

    for (String pair in pairs) {
      int row1=0, col1=0, row2=0, col2 =0;
      for (int row = 0; row < 5; row++) {
        for (int col = 0; col < 5; col++) {
          if (_matrix![row][col] == pair[0]) {
            row1 = row;
            col1 = col;
          } else if (_matrix![row][col] == pair[1]) {
            row2 = row;
            col2 = col;
          }
        }
      }

      if (row1 == row2) {
        col1 = (col1 + (encrypt ? 1 : -1) + 5) % 5;
        col2 = (col2 + (encrypt ? 1 : -1) + 5) % 5;
      } else if (col1 == col2) {
        row1 = (row1 + (encrypt ? 1 : -1) + 5) % 5;
        row2 = (row2 + (encrypt ? 1 : -1) + 5) % 5;
      } else {
        int temp = col1;
        col1 = col2;
        col2 = temp;
      }

      processedText += _matrix![row1][col1] + _matrix![row2][col2];
    }
    return processedText;
  }

  List<String> _splitIntoPairs(String text) {
    List<String> pairs = [];
    for (int i = 0; i < text.length; i += 2) {
      if (i + 1 < text.length) {
        if (text[i] == text[i + 1]) {
          pairs.add(text[i] + 'X');
          i--;
        } else {
          pairs.add(text[i] + text[i + 1]);
        }
      } else {
        pairs.add(text[i] + 'X');
      }
    }
    return pairs;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playfair Cipher',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PlayfairCipherPage(),
    );
  }
}

class PlayfairCipherPage extends StatefulWidget {
  @override
  _PlayfairCipherPageState createState() => _PlayfairCipherPageState();
}

class _PlayfairCipherPageState extends State<PlayfairCipherPage> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  void _processText(bool encrypt) {
    String key = _keyController.text;
    String input = _inputController.text;

    if (key.isEmpty || input.isEmpty) return;

    PlayfairCipher cipher = PlayfairCipher(key);
    String output = encrypt ? cipher.encrypt(input) : cipher.decrypt(input);

    setState(() {
      _outputController.text = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playfair Cipher'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _keyController,
                decoration: InputDecoration(
                  labelText: 'Key',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  labelText: 'Input',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _processText(true),
                    child: Text('Encrypt'),
                  ),
                  ElevatedButton(
                    onPressed: () => _processText(false),
                    child: Text('Decrypt'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _outputController,
                decoration: InputDecoration(
                  labelText: 'Output',
                ),
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}