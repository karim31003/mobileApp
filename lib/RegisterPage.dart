import 'package:firebase_core/firebase_core.dart'; // Initializes Firebase
import 'package:flutter/material.dart'; // Provides UI components
import 'package:firebase_auth/firebase_auth.dart'; // Manages authentication
import 'firebase_options.dart'; // Contains Firebase configuration
import 'HomePage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  // Define controllers for text fields
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
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
        title: const Text("Register Page", style: TextStyle(color: Colors.white)), // AppBar title
        backgroundColor: Colors.blue.shade600, // Set background color
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
         return Column(
            children: [
              // Email input field
              Container(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress, // Specify input type
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
                    labelText:"Email",
                    border: OutlineInputBorder(),
                    ),
                ),
              ),
              Container(
                height: 20,
              ),
              // Password input field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _password,
                  obscureText: true, // Hide input for security
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword, // Specify input type
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    labelText:"Password",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.security),
                    ), // Placeholder text
                ),
              ),
              Container(
                height: 20,
              ),
              // Button to register a new user
              TextButton(
                onPressed: () async {
                  final email = _email.text; // Get entered email
                  final password = _password.text; // Get entered password
                  try {
                    // Create a new user in Firebase Authentication
                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(userCredential); // Print user details to console
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      print('The email address is already in use.');
                      // Optionally, you can log in the user or notify them
                    }
                     else {
                      print('Error: ${e.message}');
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Home())
                );
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
}// version 0.0.3 beta
