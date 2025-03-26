import 'package:binclan/page/home.dart';
import 'package:binclan/page/login.dart';
import 'package:binclan/page/pickup.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
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
        MaterialPageRoute(
          builder: (context) => Login(),
        ), // Navigate to HomeScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/icons/image5.png', fit: BoxFit.cover),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Saving Company",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/logo.png',
                  width: 390,
                  height: 390,
                  fit: BoxFit.contain, // Ensures proper scaling
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
