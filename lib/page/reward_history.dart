import 'package:binclan/page/reward.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RedeemHistoryScreen(),
    );
  }
}

class RedeemHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> redeemHistory = List.generate(
    5,
    (index) => {
      "Promotion Code": "A-123456",
      "Discount Amount": "\$200",
      "Date Redeemed": "21/03/25",
      "Status": "used",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Reward(),));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Back button clicked")),
            );
          },
        ),
        title: const Text(
          "Redeem History",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20.0,
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.green.shade100),
                  border: TableBorder.all(color: Colors.green),
                  columns: const [
                    DataColumn(label: Text("Promotion Code")),
                    DataColumn(label: Text("Discount Amount")),
                    DataColumn(label: Text("Date Redeemed")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: redeemHistory.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item["Promotion Code"]!)),
                      DataCell(Text(item["Discount Amount"]!)),
                      DataCell(Text(item["Date Redeemed"]!)),
                      DataCell(Text(item["Status"]!)),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
