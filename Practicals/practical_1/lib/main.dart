import 'package:flutter/material.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   title: 'Flutter Demo',
   debugShowCheckedModeBanner: false, // Remove the debug ribbon from the app
   theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
   ),
   home: GreetingScreen(), // The home screen of the app is GreetingScreen
  );
 }
}

// GreetingScreen - A stateful widget as it will manage dynamic state
class GreetingScreen extends StatefulWidget {
 @override
 _GreetingScreenState createState() => _GreetingScreenState();
}

// State class for GreetingScreen
class _GreetingScreenState extends State<GreetingScreen> {
 String username = ''; // Variable to store the username entered by the user
 String greetingMessage =
  ''; // Variable to store the greeting message generated

 TextEditingController controller =
  TextEditingController(); // Controller for managing the TextField input

 // Function to generate a greeting message based on the input username
 void generateGreeting() {
  setState(() {
  greetingMessage =
    'Hello $username, Greetings of the day!'; // Update greeting message
  });
 }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: const Text(
    'Greetings App',
     style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
     ),
    ),
    backgroundColor: Colors.deepPurple, // Set the app bar background color
   ),
   body: Padding(
    padding: const EdgeInsets.all(16.0), // Add padding to the content
    child: Column(
     mainAxisAlignment:
      MainAxisAlignment.center, // Center the content vertically
     children: <Widget>[
      // TextField for entering the username
      TextField(
      controller: controller, // Connect controller to capture the input
      decoration: const InputDecoration(
        labelText: 'Enter your Username', // Label for the text field
        border:
        OutlineInputBorder(), // Add an outline border around the text field
       ),
       onChanged: (text) {
        // Update the username as the text field changes
        username = text;
       },
      ),
      const SizedBox(height: 20), // Add some space between the widgets
      // Button to trigger the greeting generation
      ElevatedButton(
      onPressed:
        generateGreeting, // Call the generateGreeting function when pressed
      child: const Text('Greet Me'),
      ),
      const SizedBox(height: 20), // Add space between button and message
      // Display the generated greeting message
     Text(
      greetingMessage,
       style: const TextStyle(
        fontSize: 18,
        fontWeight:
          FontWeight.bold), // Style for the greeting message
      ),
     ],
    ),
   ),
  );
 }
}