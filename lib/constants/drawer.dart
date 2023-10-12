import 'package:flutter/material.dart';
import 'package:samplews/memes.dart';

import '../attendance.dart';
import '../home.dart';
import '../updates.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'CODE RED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'CODE RED')));
            },
          ),
          ListTile(
            title: Text('Updates'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UpdatesPage()));
            },
          ),
          ListTile(
            title: Text('Memes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MemesPage()));
            },
          ),
          ListTile(
            title: Text('Attendance'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AttendancePage()));
            },
          ),
        ],
      ),
    );
  }
}
