import 'package:binclan/controllers/activity_controller.dart';
import 'package:binclan/controllers/points_controller.dart';
import 'package:binclan/models/activity_model.dart';
import 'package:binclan/models/point.dart';
import 'package:binclan/page/activity.dart';
import 'package:binclan/page/reward.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:binclan/components/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ActivityController _activityController = ActivityController();
  late Future<List<Activity>> _activities;
  final PointsController _pointsController = PointsController();
  late Future<AccountPoints> _pointsFuture;

  @override
  void initState() {
    super.initState();
    _activities = _activityController.fetchActivities();
    _pointsFuture = _pointsController.fetchPoints(); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/images/logopig.png',
            width: 100,
            height: 100,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChartCard(),
              const SizedBox(height: 20),
              _buildQuickActions(context),
              const SizedBox(height: 20),
              _buildRecentActivity(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
    );
  }

  Widget _buildChartCard() {
    return FutureBuilder<AccountPoints>(
      future: _pointsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text("⚠️ Error loading points"));
        }

        final points = snapshot.data!; // Assuming latest data is needed

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Export",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildLegendIndicator(Colors.cyan),
                    const SizedBox(width: 5),
                    Text(
                      "${points.totalPoints} points",
                    ), // ✅ Fetching dynamically
                    const SizedBox(width: 15),
                    _buildLegendIndicator(Colors.pink),
                    const SizedBox(width: 5),
                    Text(
                      "\$${points.cashEquivalent.toStringAsFixed(2)}",
                    ), // ✅ Fetching dynamically
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(1, points.totalPoints * 0.1),
                            FlSpot(3, points.totalPoints * 0.2),
                            FlSpot(5, points.totalPoints * 0.3),
                            FlSpot(7, points.totalPoints * 0.4),
                            FlSpot(9, points.totalPoints * 0.5),
                            FlSpot(11, points.totalPoints * 0.6),
                          ],
                          isCurved: true,
                          color: Colors.cyan,
                          dotData: FlDotData(show: false),
                          barWidth: 3,
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(1, points.cashEquivalent * 0.1),
                            FlSpot(3, points.cashEquivalent * 0.2),
                            FlSpot(5, points.cashEquivalent * 0.3),
                            FlSpot(7, points.cashEquivalent * 0.4),
                            FlSpot(9, points.cashEquivalent * 0.5),
                            FlSpot(11, points.cashEquivalent * 0.6),
                          ],
                          isCurved: true,
                          color: Colors.pink,
                          dotData: FlDotData(show: false),
                          barWidth: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLegendIndicator(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text(
            "Schedule Pickup",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RewardsScreen()),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text(
            "Redeem Points",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityScreen()),
                );
              },
              child: const Text(
                "See all",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<Activity>>(
          future: _activities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No activities found'));
            } else {
              // Take only the latest 3 activities
              final recentActivities = snapshot.data!.take(3).toList();

              return Column(
                children:
                    recentActivities.map((activity) {
                      return _buildActivityItem(activity);
                    }).toList(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildActivityItem(Activity activity) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.recycling, color: Colors.green),
        title: Text(activity.title),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("${activity.estimateWeight} kg")],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${activity.points}",
              style: const TextStyle(color: Colors.green),
            ),
            Text(
              timeago.format(activity.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      
    );
  }
}
