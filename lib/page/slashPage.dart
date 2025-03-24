import 'package:binclan/page/pickup.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Replace with your actual home screen file

class Flater extends StatefulWidget {
  const Flater({super.key});

  @override
  _FlaterState createState() => _FlaterState();
}

class _FlaterState extends State<Flater> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PickupFormPage()), // Navigate to HomeScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/icons/image5.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Saving Company",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  'assets/icons/logopig-removebg-preview.png',
                  width: 390,
                  height: 390,
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}