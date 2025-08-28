import 'package:flutter/material.dart';

class AmountToGST extends StatefulWidget {
  const AmountToGST({super.key});

  @override
  State<AmountToGST> createState() => _AmountToGSTState();
}

class _AmountToGSTState extends State<AmountToGST> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController gstController = TextEditingController();

  double? igst, cgst, sgst, total;

  void _calculate() {
    final amount = double.tryParse(amountController.text) ?? 0;
    final gstPercent = double.tryParse(gstController.text) ?? 0;

    final gstValue = (amount * gstPercent) / 100;

    setState(() {
      igst = gstValue;
      cgst = gstValue / 2;
      sgst = gstValue / 2;
      total = amount + gstValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Amount ➝ GST")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(amountController, "Base Amount"),
            const SizedBox(height: 15),
            _buildTextField(gstController, "GST Percentage"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, child: const Text("Calculate")),
            const SizedBox(height: 25),
            if (igst != null) _buildResult(),
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
        Text("IGST: ${igst!.toStringAsFixed(2)}"),
        Text("CGST: ${cgst!.toStringAsFixed(2)}"),
        Text("SGST: ${sgst!.toStringAsFixed(2)}"),
        Text("Total Amount: ${total!.toStringAsFixed(2)}"),
      ],
    );
  }
}
