import 'package:flutter/material.dart';
import 'package:timetracker/pages/homepage.dart';
import 'package:timetracker/pages/profilepage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  List bottomNavigationItems = [
    const HomePage(),
    const ProfilePage(),
  ];
  int myindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavigationItems[myindex],
      bottomNavigationBar: BottomNavigationBar(
        
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: myindex,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
      ),
    );
  }
}