import 'package:flutter/material.dart';
import 'dart:math'; // for pow()

class EMICalculator extends StatefulWidget {
  const EMICalculator({super.key});

  @override
  State<EMICalculator> createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  int currentindex = 0;
  String result = "";
  double principal = 0.0;
  double rate = 0.0;
  double tenure = 0.0;
  double totalPayment = 0.0;
  double totalInterest = 0.0;

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController tenureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EMI Calculator"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Simple Interest", Colors.blue, 0),
                  radioButton("Compound Interest", Colors.pink, 1),
                ],
              ),
              const SizedBox(height: 20.0),

              _buildInputField("Loan Amount (Principal)", "Enter Principal Amount", principalController, context),
              _buildInputField("Annual Interest Rate (%)", "Enter Interest Rate", rateController, context),
              _buildInputField("Loan Tenure (in Years)", "Enter Loan Tenure", tenureController, context),

              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      principal = double.tryParse(principalController.text) ?? 0.0;
                      rate = double.tryParse(rateController.text) ?? 0.0;
                      tenure = double.tryParse(tenureController.text) ?? 0.0;
                    });
                    if (currentindex == 0) {
                      calculateEMIWithSimpleInterest(principal, rate, tenure);
                    } else {
                      calculateEMIWithCompoundInterest(principal, rate, tenure);
                    }
                  },
                  child: const Text("Calculate EMI", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20.0),

              const Center(
                child: Text("Your EMI is :- ", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 50.0),

              Center(
                child: Text(result, style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20.0),

              const Center(
                child: Text("Total Payment Breakdown", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10.0),

              Container(
                height: 20.0,
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    value: (principal > 0 && totalPayment > 0) ? principal / totalPayment : 0.0,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBreakdown("Total Principal", "₹ ${principal.toStringAsFixed(2)}", Colors.green),
                  _buildBreakdown("Total Interest", "₹ ${totalInterest.toStringAsFixed(2)}", Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable Input Field
  Widget _buildInputField(String label, String hint, TextEditingController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18.0)),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  // 🔹 Reusable Breakdown Widget
  Widget _buildBreakdown(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16.0, color: color)),
        Text(value, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 🔹 Radio Button
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 50.0,
        child: TextButton(
          onPressed: () => setState(() => currentindex = index),
          style: TextButton.styleFrom(backgroundColor: currentindex == index ? color : Colors.grey[200]),
          child: Text(value, style: TextStyle(color: currentindex == index ? Colors.white : color)),
        ),
      ),
    );
  }

  // 🔹 EMI Calculations
  void calculateEMIWithSimpleInterest(double principal, double rate, double tenure) {
    double interest = (principal * rate * tenure) / 100;
    totalPayment = principal + interest;
    totalInterest = interest;
    result = (totalPayment / (tenure * 12)).toStringAsFixed(2);
  }

  void calculateEMIWithCompoundInterest(double principal, double rate, double tenure) {
    double monthlyRate = rate / (12 * 100);
    int n = (tenure * 12).toInt();
    totalPayment = principal * pow(1 + monthlyRate, n);
    totalInterest = totalPayment - principal;
    result = (totalPayment / n).toStringAsFixed(2);
  }
}
