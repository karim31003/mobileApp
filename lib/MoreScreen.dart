import 'package:flutter/material.dart';
import 'package:one/Contact.dart';
import 'package:one/calculator.dart';
import 'RegisterPage.dart';

class Morescreen extends StatelessWidget {
  const Morescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '  More',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            // First Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide.none,
                  ),
                  alignment: Alignment.centerLeft, // Align icon and text to left
                  padding: EdgeInsets.all(16), // Add some padding
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CarCalculatorPage()),
                  );
                },
                icon: Icon(
                  Icons.calculate,
                  color: Colors.blueAccent,
                  size: 32,
                ),
                label: Text(
                  '  Calculator',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 215, 215, 215),
              height: 1,
            ),
            
            // Second Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide.none,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUsPage()),
                  );
                },
                icon: Icon(
                  Icons.mail,
                  color: Colors.blueAccent,
                  size: 32,
                ),
                label: Text(
                  '  Contact Us',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 215, 215, 215),
              height: 1,
            ),
            
            // Third Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide.none,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  size: 32,
                ),
                label: Text(
                  '  Logout',
                  style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0), fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}