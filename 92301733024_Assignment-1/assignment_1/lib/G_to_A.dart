import 'package:flutter/material.dart';

class GSTToAmount extends StatefulWidget {
  const GSTToAmount({super.key});

  @override
  State<GSTToAmount> createState() => _GSTToAmountState();
}

class _GSTToAmountState extends State<GSTToAmount> {
  final TextEditingController totalController = TextEditingController();
  final TextEditingController gstController = TextEditingController();

  double? actual, igst, cgst, sgst;

  void _calculate() {
    final total = double.tryParse(totalController.text) ?? 0;
    final gstPercent = double.tryParse(gstController.text) ?? 0;

    final baseAmount = total / (1 + gstPercent / 100);
    final gstValue = total - baseAmount;

    setState(() {
      actual = baseAmount;
      igst = gstValue;
      cgst = gstValue / 2;
      sgst = gstValue / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GST ➝ Amount")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(totalController, "Total Amount (with GST)"),
            const SizedBox(height: 15),
            _buildTextField(gstController, "GST Percentage"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, child: const Text("Calculate")),
            const SizedBox(height: 25),
            if (actual != null) _buildResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Actual Amount: ${actual!.toStringAsFixed(2)}"),
        Text("IGST: ${igst!.toStringAsFixed(2)}"),
        Text("CGST: ${cgst!.toStringAsFixed(2)}"),
        Text("SGST: ${sgst!.toStringAsFixed(2)}"),
      ],
    );
  }
}
