import 'package:flutter/material.dart';

class PickupHistoryPage extends StatelessWidget {
  const PickupHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Pickup history",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Image.asset('assets/icons/image 7.png', height: 266, width: 306,),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Active Pickup Section
            Text("Active pickup", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildPickupCard("Monday, June, 2025", "10:00am", "Plastic", "Cancel", Colors.red),

            _buildPickupCard("Monday, June, 2025", "10:00am", "Plastic", "Cancel", Colors.red),
            SizedBox(height: 20),

            // Past Pickup Section
            Text("Past pickup", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildPickupCard("Monday, June, 2025", "10:00am", "Plastic", "Done", const Color.fromARGB(255, 4, 70, 6)),

            _buildPickupCard("Monday, June, 2025", "10:00am", "Plastic", "Done", const Color.fromARGB(255, 4, 70, 6)),
          ],
        ),
      ),
    );
  }

  Widget _buildPickupCard(String date, String time, String type, String buttonText, Color buttonColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.white),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(time, style: TextStyle(color: Colors.white)),
                  Text(type, style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
            onPressed: () {},
            child: Text(buttonText, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}