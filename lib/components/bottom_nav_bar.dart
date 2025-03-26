import 'package:binclan/page/home.dart';
import 'package:binclan/page/socail.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            break;
          case 1:
            Navigator.pushNamed(context, '/pickup-history');
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => SocialScreen(),));
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Pickup History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.eco),
          label: 'Green Social',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}