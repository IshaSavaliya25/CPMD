import 'package:flutter/material.dart';
import 'Amount_to_GST.dart';
import 'G_to_A.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GST Calculator"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuButton(
                context,
                title: "Amount ➝ GST",
                screen: const AmountToGST(),
              ),
              const SizedBox(height: 25),
              _buildMenuButton(
                context,
                title: "GST ➝ Amount",
                screen: const GSTToAmount(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable menu button widget
  Widget _buildMenuButton(BuildContext context,
      {required String title, required Widget screen}) {
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
