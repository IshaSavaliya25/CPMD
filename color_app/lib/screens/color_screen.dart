import 'package:flutter/material.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  List color = [
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.green,
    Colors.red,
  ];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            color: color[count % 5],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            color: color[(count + 1) % 5],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            color: color[(count + 2) % 5],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            color: color[(count + 3) % 5],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            color: color[(count + 4) % 5],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: Text('Move up'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text('Move Down'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      count = 0;
                    });
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
