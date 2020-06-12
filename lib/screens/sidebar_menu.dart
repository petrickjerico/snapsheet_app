import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addcategory_screen.dart';
import 'package:snapsheetapp/screens/bulk_scan_screen.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/archive/bulkinput_screen.dart';
import 'package:snapsheetapp/screens/editprofile_screen.dart';
import 'package:snapsheetapp/screens/exportselect_screen.dart';
import 'package:snapsheetapp/screens/settings_screen.dart';

class SidebarMenu extends StatelessWidget {
  SidebarMenu({@required this.currentUser});

  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Hi, you!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.file_upload),
                title: Text('Export'),
                onTap: () {
                  userData.Export();
                  Navigator.pushNamed(context, ExportSelectScreen.id);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle),
                title: Text('Add category'),
                onTap: () =>
                    {Navigator.pushNamed(context, AddCategoryScreen.id)},
              ),
              ListTile(
                leading: Icon(Icons.filter),
                title: Text('Bulk-input receipts'),
                onTap: () => {Navigator.pushNamed(context, BulkScanScreen.id)},
              ),
              ListTile(
                leading: Icon(Icons.mode_edit),
                title: Text('Edit profile'),
                onTap: () =>
                    {Navigator.pushNamed(context, EditProfileScreen.id)},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => {Navigator.pushNamed(context, SettingsScreen.id)},
              ),
            ],
          ),
        );
      },
    );
  }
}
