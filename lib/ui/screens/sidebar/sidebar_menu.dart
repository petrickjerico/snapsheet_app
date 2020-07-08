import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class SidebarMenu extends StatelessWidget {
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
                leading: Icon(Icons.import_export),
                title: Text('Export'),
                onTap: () {
                  Navigator.pushNamed(context, ExportScreen.id);
                },
              ),
//              ListTile(
//                leading: Icon(Icons.add_circle),
//                title: Text('Add category'),
//                onTap: () =>
//                    {Navigator.pushNamed(context, AddCategoryScreen.id)},
//              ),
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
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () => logout(context),
              )
            ],
          ),
        );
      },
    );
  }

  logout(BuildContext context) {
    AuthService authService = AuthServiceImpl();
    authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.id,
      (route) => false,
    );
  }
}
