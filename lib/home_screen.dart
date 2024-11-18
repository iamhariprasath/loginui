import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          textAlign: TextAlign.center, // Center the text
          text: TextSpan(
            text: 'Welcome to ', // First part in black and bold
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Intellion Technologies', // Blue and italic part
                style: TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal, // Remove bold for this part
                ),
              ),
              TextSpan(
                text: '', // Empty part for the space
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
