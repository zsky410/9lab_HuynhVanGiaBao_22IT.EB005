import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const DiceeApp());
}

class DiceeApp extends StatelessWidget {
  const DiceeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceePage(),
    );
  }
}

class DiceePage extends StatefulWidget {
  const DiceePage({super.key});

  @override
  State<DiceePage> createState() => _DiceePageState();
}

class _DiceePageState extends State<DiceePage> {
  final Random _random = Random();
  int _leftDice = 1;
  int _rightDice = 1;

  void _rollDice() {
    setState(() {
      _leftDice = _random.nextInt(6) + 1;
      _rightDice = _random.nextInt(6) + 1;
    });
  }

  String _face(int value) {
    const faces = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
    return faces[value - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      appBar: AppBar(
        title: const Text('Dicee'),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DiceCard(face: _face(_leftDice), onTap: _rollDice),
                const SizedBox(width: 16),
                _DiceCard(face: _face(_rightDice), onTap: _rollDice),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _rollDice,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red.shade900,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Roll Dice'),
            )
          ],
        ),
      ),
    );
  }
}

class _DiceCard extends StatelessWidget {
  const _DiceCard({required this.face, required this.onTap});

  final String face;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          face,
          style: const TextStyle(fontSize: 72, height: 1),
        ),
      ),
    );
  }
}
