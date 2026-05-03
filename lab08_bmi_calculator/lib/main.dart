import 'package:flutter/material.dart';
import 'core/bmi_calculator.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111328),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const InputPage(),
    );
  }
}

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 170;
  int weight = 60;
  int age = 20;

  Widget _buildCard({required Widget child, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1D1E33),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      constraints: const BoxConstraints.tightFor(width: 46, height: 46),
      child: Icon(icon, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Column(
        children: [
            Row(
              children: [
                _buildCard(
                  onTap: () => setState(() => selectedGender = Gender.male),
                  child: _GenderCard(
                    label: 'Nam',
                    icon: Icons.male,
                    selected: selectedGender == Gender.male,
                  ),
                ),
                _buildCard(
                  onTap: () => setState(() => selectedGender = Gender.female),
                  child: _GenderCard(
                    label: 'Nữ',
                    icon: Icons.female,
                    selected: selectedGender == Gender.female,
                  ),
                ),
              ],
            ),
            _buildCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('CHIỀU CAO', style: TextStyle(color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$height',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(' cm', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120,
                    max: 220,
                    activeColor: Colors.pink,
                    onChanged: (value) => setState(() => height = value.round()),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildCard(
                  child: _NumberAdjustCard(
                    title: 'CÂN NẶNG',
                    value: weight,
                    onPlus: () => setState(() => weight++),
                    onMinus: () => setState(() => weight--),
                    roundButton: _roundButton,
                  ),
                ),
                _buildCard(
                  child: _NumberAdjustCard(
                    title: 'TUỔI',
                    value: age,
                    onPlus: () => setState(() => age++),
                    onMinus: () => setState(() => age--),
                    roundButton: _roundButton,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEB1555),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  final BmiCalculator calculator =
                      BmiCalculator(heightCm: height, weightKg: weight);

                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ResultPage(
                        bmi: calculator.calculateBmi(),
                        resultText: calculator.getResultText(),
                        interpretation: calculator.getInterpretation(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'TÍNH BMI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  const _GenderCard({
    required this.label,
    required this.icon,
    required this.selected,
  });

  final String label;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 78, color: selected ? Colors.pink : Colors.white),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 18)),
      ],
    );
  }
}

class _NumberAdjustCard extends StatelessWidget {
  const _NumberAdjustCard({
    required this.title,
    required this.value,
    required this.onPlus,
    required this.onMinus,
    required this.roundButton,
  });

  final String title;
  final int value;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final Widget Function(IconData, VoidCallback) roundButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            roundButton(Icons.remove, onMinus),
            const SizedBox(width: 10),
            roundButton(Icons.add, onPlus),
          ],
        )
      ],
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.bmi,
    required this.resultText,
    required this.interpretation,
  });

  final double bmi;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả BMI')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  'Kết quả của bạn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1E33),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultText.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF24D876),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 84,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        interpretation,
                        style:
                            const TextStyle(color: Colors.white70, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEB1555),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'TÍNH LẠI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
