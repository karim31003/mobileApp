import 'package:flutter/material.dart';
import 'package:one/Contact.dart';
import 'package:one/calculator.dart';
import 'RegisterPage.dart';

class Morescreen
    extends
        StatelessWidget {
  const Morescreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '  More',
          style: TextStyle(
            color:
                Colors.white,
          ),
        ),
        backgroundColor:
            Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
         3.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Makes the background transparent
    shadowColor: Colors.transparent, // Removes any shadow
    elevation: 0, // Ensures no shadow effect
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, // Removes border radius
      side: BorderSide.none, // Removes the border completely
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarCalculatorApp(),
      ),
    );
  },
  icon: Icon(
    Icons.calculate,
    color: Colors.blueAccent,
    size: 32,
  ),
  label: Text('  Calculator',style: TextStyle(color: Colors.blueAccent,fontSize: 18)
  )
  ),
  const Divider(
    color: Color.fromARGB(255, 215, 215, 215),
    indent: 50,
    endIndent: 50,
  ),
  ///////////////////////////////////////////////////////////////////////////////////////
  ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Makes the background transparent
    shadowColor: Colors.transparent, // Removes any shadow
    elevation: 0, // Ensures no shadow effect
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, // Removes border radius
      side: BorderSide.none, // Removes the border completely
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactUsPage(),
      ),
    );
  },
  icon: Icon(
    Icons.mail,
    color: Colors.blueAccent,
    size: 32,
  ),
  label: Text('  Contact Us',style: TextStyle(color: Colors.blueAccent,fontSize: 18)
  )
  ),const Divider(
    color: Color.fromARGB(255, 215, 215, 215),
    indent: 50,
    endIndent: 50,
  ),
  ///////////////
   ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Makes the background transparent
    shadowColor: Colors.transparent, // Removes any shadow
    elevation: 0, // Ensures no shadow effect
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, // Removes border radius
      side: BorderSide.none, // Removes the border completely
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  },
  icon: Icon(
    Icons.logout,
    color: const Color.fromARGB(255, 255, 0, 0),
    size: 32,
  ),
  label: Text('  Logout',style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0),fontSize: 18)
  )
  ),
  // const Divider(
  //   color: Color.fromARGB(255, 215, 215, 215),
  //   indent: 50,
  //   endIndent: 50,
  // )

],
        ),
      ),
    );
  }
}
