import 'package:flutter/material.dart';

/// A single screen that handles Length, Weight, Temperature, and Area conversions
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  // Dropdown selection
  String selectedCategory = "Length";

  // Input and result
  final TextEditingController inputController = TextEditingController();
  String result = "";

  // Conversion logic
  void convert() {
    double? value = double.tryParse(inputController.text);
    if (value == null) {
      setState(() => result = "Enter valid number");
      return;
    }

    switch (selectedCategory) {
      case "Length":
        // Kilometers to Meters
        setState(() => result = "${value * 1000} meters");
        break;

      case "Weight":
        // Kilograms to Grams
        setState(() => result = "${value * 1000} grams");
        break;

      case "Temperature":
        // Celsius to Fahrenheit
        setState(() => result = "${(value * 9 / 5) + 32} °F");
        break;

      case "Area":
        // Square meters to Square centimeters
        setState(() => result = "${value * 10000} cm²");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unit Converter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for category selection
            DropdownButton<String>(
              value: selectedCategory,
              items: const [
                DropdownMenuItem(value: "Length", child: Text("Length (km to m)")),
                DropdownMenuItem(value: "Weight", child: Text("Weight (kg to g)")),
                DropdownMenuItem(value: "Temperature", child: Text("Temperature (°C to °F)")),
                DropdownMenuItem(value: "Area", child: Text("Area (m² to cm²)")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                  result = "";
                  inputController.clear();
                });
              },
            ),

            const SizedBox(height: 20),

            // Input field
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter $selectedCategory value",
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Convert button
            ElevatedButton(
              onPressed: convert,
              child: const Text("Convert"),
            ),

            const SizedBox(height: 20),

            // Result
            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
