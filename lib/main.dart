import 'package:flutter/material.dart';

void main() => runApp(BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Color(0xFF1A1B2F),
        sliderTheme: SliderThemeData(
          thumbColor: Colors.tealAccent,
          activeTrackColor: Colors.teal,
        ),
      ),
      home: BMIScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMIScreen extends StatefulWidget {
  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  double height = 165; // in cm
  double weight = 65; // in kg

  double get bmi => weight / ((height / 100) * (height / 100));

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight 😕";
    if (bmi < 24.9) return "Normal ✅";
    if (bmi < 29.9) return "Overweight ⚠️";
    return "Obese 🚨";
  }

  Color getColor(double bmi) {
    if (bmi < 18.5) return Colors.blueAccent;
    if (bmi < 24.9) return Colors.green;
    if (bmi < 29.9) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final bmiValue = bmi.toStringAsFixed(1);
    final category = getBMICategory(bmi);
    final categoryColor = getColor(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSliderCard(
              label: "Height",
              value: height,
              unit: "cm",
              min: 100,
              max: 220,
              onChanged: (val) => setState(() => height = val),
            ),
            _buildSliderCard(
              label: "Weight",
              value: weight,
              unit: "kg",
              min: 30,
              max: 150,
              onChanged: (val) => setState(() => weight = val),
            ),
            SizedBox(height: 30),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: categoryColor, width: 2),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Your BMI is:", style: TextStyle(fontSize: 18, color: Colors.white60)),
                  SizedBox(height: 10),
                  Text(bmiValue, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: categoryColor)),
                  SizedBox(height: 10),
                  Text(category, style: TextStyle(fontSize: 22, color: categoryColor, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderCard({
    required String label,
    required double value,
    required String unit,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Color(0xFF2D2F41),
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$label: ${value.toStringAsFixed(0)} $unit",
                style: TextStyle(fontSize: 18, color: Colors.tealAccent)),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              label: value.toStringAsFixed(0),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
