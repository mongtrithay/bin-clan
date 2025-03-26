import 'package:flutter/material.dart';
import 'package:binclan/models/pickup_model.dart';
import 'package:binclan/controllers/pickup_controller.dart';

class PickupHistoryPage extends StatefulWidget {
  const PickupHistoryPage({super.key});

  @override
  _PickupHistoryPageState createState() => _PickupHistoryPageState();
}

class _PickupHistoryPageState extends State<PickupHistoryPage> {
  final ShchedulehistoryController _pickupService = ShchedulehistoryController();
  late Future<List<PickupModel>> _pickupHistoryFuture;

  @override
  void initState() {
    super.initState();
    _pickupHistoryFuture = _pickupService.fetchScheduledHistory();  // Correct method call
  }

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
      body: FutureBuilder<List<PickupModel>>(
        future: _pickupHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No pickup history available"));
          }

          List<PickupModel> pickups = snapshot.data!;

          return SingleChildScrollView(
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
                      Image.asset('assets/icons/image 7.png', height: 266, width: 306),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Active Pickup Section
                Text("Active Pickup", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                if (pickups.any((p) => p.recurring)) ...pickups
                    .where((p) => p.recurring)
                    .map((p) {
                      return _buildPickupCard(p.date, p.wasteTypes.join(', '), p.estimateWeight.toString(), "Cancel", Colors.red);
                    }).toList(),

                SizedBox(height: 20),

                // Past Pickup Section
                Text("Past Pickup", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                if (pickups.any((p) => !p.recurring)) ...pickups
                    .where((p) => !p.recurring)
                    .map((p) {
                      return _buildPickupCard(p.date, p.wasteTypes.join(', '), p.estimateWeight.toString(), "Done", Color.fromARGB(255, 4, 70, 6));
                    }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPickupCard(String date, String wasteTypes, String estimateWeight, String buttonText, Color buttonColor) {
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
                  Text("Waste Types: $wasteTypes", style: TextStyle(color: Colors.white)),
                  Text("Estimated Weight: $estimateWeight kg", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, 
              foregroundColor: Colors.white, 
            ),
            onPressed: () {
              // Handle button action (e.g., Cancel or Done)
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
