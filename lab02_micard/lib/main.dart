import 'package:flutter/material.dart';

void main() {
  runApp(const MiCardApp());
}

class MiCardApp extends StatelessWidget {
  const MiCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MiCardPage(),
    );
  }
}

class MiCardPage extends StatelessWidget {
  const MiCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF008080),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 52,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, size: 56, color: Colors.white),
            ),
            const SizedBox(height: 14),
            const Text(
              'Huynh Van Gia Bao',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                color: Color(0xFFE0F2F1),
                fontSize: 14,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 180,
              height: 1,
              color: const Color(0xFFB2DFDB),
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFF00796B)),
                title: Text(
                  '0935177318',
                  style: TextStyle(color: Colors.teal.shade900),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.email, color: Color(0xFF00796B)),
                title: Text(
                  'baohvg.22ite@vku.udn.vn',
                  style: TextStyle(color: Colors.teal.shade900),
                ),
              ),
            ),
            Text(
              'Lab 2 - MiCard',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
