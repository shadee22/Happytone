// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:happytone/shared/reuse.dart';

class DrawerSettings extends StatefulWidget {
  const DrawerSettings({Key? key}) : super(key: key);

  @override
  _DrawerSettingsState createState() => _DrawerSettingsState();
}

class _DrawerSettingsState extends State<DrawerSettings> {
  bool sUpload = Settings.upload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Show Upload'),
            trailing: Switch(
                onChanged: (value) {
                  setState(() {
                    sUpload = value;
                    Settings.upload = value;
                  });
                },
                value: sUpload),
          ),
        ],
      ),
    );
  }
}

//Model classs

class Settings {
  static bool upload = false;
}
