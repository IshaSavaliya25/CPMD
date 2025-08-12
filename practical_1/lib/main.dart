import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Entry point of the app
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Greeting App',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Set theme colors
        useMaterial3: true,
      ),
      home: const GreetingScreen(), // Set the home screen
    );
  }
}

// GreetingScreen - A stateful widget to manage user input and greeting message
class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

// State class for GreetingScreen
class _GreetingScreenState extends State<GreetingScreen> {
  String username = ''; 
  String greetingMessage = ''; 

  final TextEditingController controller =
      TextEditingController(); 

  // Function to generate greeting message
  void generateGreeting() {
    if (username.trim().isEmpty) {
      // If no name entered, show warning message
      setState(() {
        greetingMessage = 'Please enter your name!';
      });
    } else {
      // If name entered, show greeting
      setState(() {
        greetingMessage = 'Hello $username, Greetings of the day!';
        controller.clear(); // Clear the text field
        username = ''; // Reset the username variable
      });
    }
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
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 20), 
              TextField(
                controller: controller, // Attach controller to TextField
                decoration: const InputDecoration(
                  labelText: 'Enter your name', 
                  border: OutlineInputBorder(), 
                ),
                onChanged: (text) {
                  username = text; 
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateGreeting, // Call function on button press
                child: const Text('Greet Me'), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, 
                  foregroundColor: Colors.white, 
                ),
              ),
              const SizedBox(height: 30), 
              Text(
                greetingMessage, // Display the generated greeting
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple, 
                ),
                textAlign: TextAlign.center, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
