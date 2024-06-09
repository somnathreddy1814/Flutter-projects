import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextToSpeechScreen(),
    );
  }
}

class TextToSpeechScreen extends StatefulWidget {
  @override
  _TextToSpeechScreenState createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  final TextEditingController _textController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  String _status = '';

  Future<void> _convertTextToSpeech() async {
    if (_textController.text.trim().isEmpty) {
      setState(() {
        _status = 'Nothing to Convert! Enter text in the text area.';
      });
      return;
    }

    setState(() {
      _status = 'Playing Sound...';
    });

    await _flutterTts.speak(_textController.text);
    setState(() {
      _status = 'Play Converted Sound';
    });
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> _downloadAudio() async {
    await _requestPermission();

    if (_textController.text.trim().isEmpty) {
      setState(() {
        _status = 'Nothing to Convert! Enter text in the text area.';
      });
      return;
    }

    if (await Permission.storage.isGranted) {
      final fileName = await _getFileNameFromUser();
      if (fileName == null || fileName.trim().isEmpty) {
        setState(() {
          _status = 'File name cannot be empty.';
        });
        return;
      }

      final downloadDirectory = Directory('/storage/emulated/0/Download');

      if (!await downloadDirectory.exists()) {
        await downloadDirectory.create(recursive: true);
      }

      final filePath = '${downloadDirectory.path}/$fileName.wav';

      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      await _flutterTts.synthesizeToFile(
        _textController.text,
        filePath,
      );

      setState(() {
        _status = 'Audio file saved at $filePath';
      });
    } else {
      setState(() {
        _status = 'Permission denied. Please enable storage permissions in your settings.';
      });
    }
  }

  Future<String?> _getFileNameFromUser() async {
    String? fileName;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter file name'),
          content: TextField(
            onChanged: (value) {
              fileName = value;
            },
            decoration: InputDecoration(hintText: "File name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(fileName);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text here',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _convertTextToSpeech,
                  icon: Icon(Icons.volume_up),
                  label: Text('Speak'),
                ),
                ElevatedButton.icon(
                  onPressed: _downloadAudio,
                  icon: Icon(Icons.download),
                  label: Text('Download'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              _status,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _textController.dispose();
    super.dispose();
  }
}
