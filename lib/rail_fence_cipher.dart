import 'package:flutter/material.dart';

class RailFenceCipher extends StatefulWidget {
  @override
  _RailFenceCipherState createState() => _RailFenceCipherState();
}

class _RailFenceCipherState extends State<RailFenceCipher> {
  String _inputText = '';
  String _outputText = '';
  int _numRails = 2;
  bool _isEncrypting = true;

  void _onInputTextChanged(String value) {
    setState(() {
      _inputText = value;
    });
  }

  void _onNumRailsChanged(double value) {
    setState(() {
      _numRails = value.round();
    });
  }

  void _onEncryptPressed() {
    setState(() {
      _isEncrypting = true;
      _outputText = _encrypt(_inputText, _numRails);
    });
  }

  void _onDecryptPressed() {
    setState(() {
      _isEncrypting = false;
      _outputText = _decrypt(_inputText, _numRails);
    });
  }

  String _encrypt(String input, int numRails) {
    List<StringBuffer> rails = List.generate(numRails, (_) => StringBuffer());
    int rail = 0;
    bool goingDown = false;

    for (int i = 0; i < input.length; i++) {
      rails[rail].write(input[i]);
      if (rail == 0 || rail == numRails - 1) {
        goingDown = !goingDown;
      }
      rail += goingDown ? 1 : -1;
    }

    return rails.map((sb) => sb.toString()).join();
  }

  String _decrypt(String input, int numRails) {
    List<StringBuffer> rails = List.generate(numRails, (_) => StringBuffer());
    List<int> lengths = List.generate(numRails, (_) => 0);
    int rail = 0;
    bool goingDown = false;

    for (int i = 0; i < input.length; i++) {
      lengths[rail]++;
      if (rail == 0 || rail == numRails - 1) {
        goingDown = !goingDown;
      }
      rail += goingDown ? 1 : -1;
    }

    List<String> encryptedRails = [];
    int index = 0;
    for (int i = 0; i < numRails; i++) {
      encryptedRails.add(input.substring(index, index + lengths[i]));
      index += lengths[i];
    }

    rail = 0;
    goingDown = false;
    index = 0;
    for (int i = 0; i < input.length; i++) {
      rails[rail].write(encryptedRails[rail][index]);
      if (index < lengths[rail] - 1) {
        index++;
      } else {
        index = 0;
        rail++;
      }
      if (rail == 0 || rail == numRails - 1) {
        goingDown = !goingDown;
      }
      rail += goingDown ? 1 : -1;
    }

    return rails.map((sb) => sb.toString()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rail Fence Cipher')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: _onInputTextChanged,
              decoration: InputDecoration(labelText: 'Input Text'),
            ),
            SizedBox(height: 16.0),
            Text('Number of Rails: $_numRails'),
            Slider(
              value: _numRails.toDouble(),
              min: 2,
              max: 10,
              onChanged: _onNumRailsChanged,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _onEncryptPressed,
                  child: Text('Encrypt'),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: _onDecryptPressed,
                  child: Text('Decrypt'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Output Text:'),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_outputText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


