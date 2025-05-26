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
  String? _errorMessage;
  bool _isLoading = false;
  bool _isObscured = true;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\u0000?[^@\s]*');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

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
        automaticallyImplyLeading: false,
        title: const Text("Register Page", style: TextStyle(color: Colors.white)), // AppBar title
        backgroundColor: Colors.blue.shade600, // Set background color
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Email input field
            Container(
            height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress, // Specify input type
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (_errorMessage == 'Please enter a valid email address.' || _errorMessage == 'This email is already registered. Please use another email or log in.')
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),
            Container(
            height: 12,
            ),
            // Password input field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _password,
                    obscureText: _isObscured,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  if (_errorMessage == 'Password must be at least 6 characters.')
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),
            Container(
            height: 20,
            ),
            // Button to register a new user
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final email = _email.text.trim();
                  final password = _password.text;
                  setState(() { _errorMessage = null; _isLoading = true; });
                  if (!_isValidEmail(email)) {
                    setState(() {
                      _errorMessage = 'Please enter a valid email address.';
                      _isLoading = false;
                    });
                    return;
                  }
                  if (!_isValidPassword(password)) {
                    setState(() {
                      _errorMessage = 'Password must be at least 6 characters.';
                      _isLoading = false;
                    });
                    return;
                  }
                  try {
                    // Create a new user in Firebase Authentication
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      if (e.code == 'email-already-in-use') {
                        _errorMessage = 'This email is already registered. Please use another email or log in.';
                      } else {
                        _errorMessage = e.message;
                      }
                    });
                  } finally {
                    setState(() { _isLoading = false; });
                  }
                },
                child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('SIGN UP', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// version 0.0.3 beta
