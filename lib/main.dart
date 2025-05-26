// import 'RegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}//version 0.1.8 beta 

//next updates 
//add login page
//edit description page 
//edit search by name 
//add recent page 
//edit contact us
//edit calc
//add more cars 
//link all search ways to one file 
//rewrite the code with ai