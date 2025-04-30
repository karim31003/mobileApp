// Import necessary packages
import 'package:firebase_core/firebase_core.dart'; // Initializes Firebase
import 'package:flutter/material.dart'; // Provides UI components
import 'package:firebase_auth/firebase_auth.dart'; // Manages authentication
import 'firebase_options.dart'; // Contains Firebase configuration

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo', // App title
    theme: ThemeData(), // Define the theme
    home: const HomePage(), // Set HomePage as the start screen
  ));
}

// HomePage is a StatefulWidget because it needs to update UI dynamically
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// _HomePageState manages the UI and user interactions
class _HomePageState extends State<HomePage> {
  // Define controllers for text fields
  late final TextEditingController _email;
  late final TextEditingController _password;

  // Initialize controllers when the widget is created
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  // Dispose controllers when the widget is removed to free up memory
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Cart", style: TextStyle(color: Colors.white)), // AppBar title
        backgroundColor: Colors.blue.shade600, // Set background color
      ),
      body: FutureBuilder(
        // Wait for Firebase to initialize before displaying the UI
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            
          
            case ConnectionState.done:
              // TODO: Handle this case.
         return Column(
            children: [
              // Email input field
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress, // Specify input type
                decoration: InputDecoration(hintText: "Enter your email"), // Placeholder text
              ),
              // Password input field
              TextField(
                controller: _password,
                obscureText: true, // Hide input for security
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword, // Specify input type
                decoration: InputDecoration(hintText: "Enter your password"), // Placeholder text
              ),
              // Button to register a new user
              TextButton(
                onPressed: () async {
                  final email = _email.text; // Get entered email
                  final password = _password.text; // Get entered password

                  // Create a new user in Firebase Authentication
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print(userCredential); // Print user details to console
                },
                child: const Text('Register'), // Button text
              ),
            ],
          );
          default:
            return const Text("Loadind....");
          }
          
        },
      ),
    );
  }
}// version 0.0.2
