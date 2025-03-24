import 'package:binclan/controllers/activity_controller.dart';
import 'package:binclan/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ActivityController _activityController = ActivityController();
  late Future<List<Activity>> _activities;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  void _loadActivities() {
    setState(() {
      _activities = _activityController.fetchActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity')),
      body: FutureBuilder<List<Activity>>(
        future: _activities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _loadActivities,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activities found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final activity = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.recycling, color: Colors.green),
                    title: Text(activity.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("${activity.estimateWeight} kg")],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${activity.points}",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          timeago.format(
                            activity.date,
                            locale: 'hours',
                          ), 
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
