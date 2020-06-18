// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/accounts_tab.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';
import 'package:snapsheetapp/screens/history_tab.dart';
import 'package:snapsheetapp/screens/sidebar_menu.dart';

import 'authentication/welcome_screen.dart';

//final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomepageScreen extends StatefulWidget {
  static final String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('HOMEPAGE'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'ACCOUNTS'),
                Tab(text: 'HISTORY'),
              ],
              indicatorColor: Colors.white,
              indicatorWeight: 5.0,
            ),
          ),
          drawer: SidebarMenu(currentUser: loggedInUser),
          body: TabBarView(
            children: <Widget>[
              AccountsTab(),
              HistoryTab(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
            onPressed: () {
              userData.newRecord();
              Navigator.pushNamed(context, AddExpensesScreen.id);
            },
          ),
        ),
      );
    });
  }
}
