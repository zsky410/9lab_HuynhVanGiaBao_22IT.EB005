import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key});

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  final AudioPlayer _player = AudioPlayer();

  Future<void> _playNote(int noteNumber) async {
    await _player.stop();
    await _player.play(AssetSource('audio/note$noteNumber.wav'));
  }

  Widget _buildKey({required Color color, required int note}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: () => _playNote(note),
        child: const SizedBox.expand(),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildKey(color: Colors.red, note: 1),
            _buildKey(color: Colors.orange, note: 2),
            _buildKey(color: Colors.yellow, note: 3),
            _buildKey(color: Colors.green, note: 4),
            _buildKey(color: Colors.teal, note: 5),
            _buildKey(color: Colors.blue, note: 6),
            _buildKey(color: Colors.purple, note: 7),
          ],
        ),
      ),
    );
  }
}
