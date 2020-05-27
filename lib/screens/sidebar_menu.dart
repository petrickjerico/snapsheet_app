import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/addcategory_screen.dart';
import 'package:snapsheetapp/screens/editprofile_screen.dart';
import 'package:snapsheetapp/screens/exportselect_screen.dart';
import 'package:snapsheetapp/screens/settings_screen.dart';

class SidebarMenu extends StatelessWidget {
  SidebarMenu({@required this.currentUser});

  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '${currentUser.email}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Export'),
            onTap: () => {Navigator.pushNamed(context, ExportSelectScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Add category'),
            onTap: () => {Navigator.pushNamed(context, AddCategoryScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Edit profile'),
            onTap: () => {Navigator.pushNamed(context, EditProfileScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.pushNamed(context, SettingsScreen.id)},
          ),
        ],
      ),
    );
  }
}
