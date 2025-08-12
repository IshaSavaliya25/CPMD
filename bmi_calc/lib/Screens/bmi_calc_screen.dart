import 'package:flutter/material.dart';

class BmiCalcScreen extends StatefulWidget {
  BmiCalcScreen({super.key});

  @override
  State<BmiCalcScreen> createState() => _BmiCalcScreenState();
}

class _BmiCalcScreenState extends State<BmiCalcScreen> {
  TextEditingController wtTxtController = TextEditingController();

  TextEditingController htTxtController = TextEditingController();

  double result = 0;
  String msg = '';
  int color = 0xffd32f2e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calc')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: wtTxtController,
              decoration: InputDecoration(
                hintText: "Enter weight in kg",
                labelText: "Weight in kg",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: htTxtController,
              decoration: InputDecoration(
                hintText: "Enter height in meter",
                labelText: "Height in meter",
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                double wt = double.parse(wtTxtController.text);
                double ht = double.parse(htTxtController.text);
                result = wt / (ht * ht);
                if (result < 16) {
                  msg = 'Severe Thickness';
                  color = 0xffd32f2e;
                } else if (result < 17) {
                  msg = 'Moderate Thickness';
                  color = 0xfff5511e;
                } else if (result < 18.5) {
                  msg = 'Mild Thickness';
                  color = 0xffff9f00;
                } else if (result < 25) {
                  msg = 'Normal';
                  color = 0xff00acc2;
                } else if (result < 30) {
                  msg = 'Overweight';
                  color = 0xff009788;
                } else if (result < 35) {
                  msg = 'Obese I';
                  color = 0xffff9f00;
                } else if (result < 40) {
                  msg = 'Obese II';
                  color = 0xfff5511e;
                } else if (result >= 40) {
                  msg = 'Obese III';
                  color = 0xffd32f2e;
                }
                setState(() {});
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Result : ${result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 25),
            ),
            Text('$msg', style: TextStyle(fontSize: 25, color: Color(color))),
          ],
        ),
      ),
    );
  }
}
