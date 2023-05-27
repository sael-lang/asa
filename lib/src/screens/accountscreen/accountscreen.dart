
import 'package:ASA/src/screens/loginscreen/loginscreen.dart';
import 'package:ASA/src/screens/homescreen/homescreen.dart';
import 'package:ASA/src/screens/servicescreen/servicescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settingscreen/settingscreen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 0;


final List<Widget> _widgetOptions = <Widget>[
  homescreen(),
  ServiceScreen(),
  SettingScreen(),
];

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
