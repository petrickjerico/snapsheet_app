// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/config/config.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/calculator/addexpenses_screen.dart';
import 'package:snapsheetapp/screens/home/accounts_tab.dart';
import 'package:snapsheetapp/screens/sidebar/sidebar_menu.dart';
import 'package:snapsheetapp/screens/wrapper.dart';
import 'package:snapsheetapp/services/auth.dart';

import '../authentication/welcome_screen.dart';
import 'history_tab.dart';

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
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('HOMEPAGE'),
        ),
        drawer: SidebarMenu(currentUser: loggedInUser),
        body: PageView(
          children: <Widget>[
            AccountsTab(),
            HistoryTab(),
          ],
        ),
        floatingActionButton: Material(
          elevation: 16.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: kBlack),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: OpenContainer(
            transitionType: ContainerTransitionType.fade,
            closedColor: kBlack,
            closedShape: RoundedRectangleBorder(
              side: BorderSide(color: kBlack),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            openBuilder: (context, _) {
              userData.newRecord();
              return AddExpensesScreen();
            },
            closedBuilder: (context, _) => FloatingActionButton(
              elevation: 0.0,
              backgroundColor: kBlack,
              child: Icon(Icons.add),
            ),
          ),
        ),
      );
    });
  }
}
