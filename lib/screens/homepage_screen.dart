import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/welcome_screen.dart';

// final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomepageScreen extends StatefulWidget {
  static final String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String messageText;

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
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: FlatButton(
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              // show sidebar menu
            },
          ),
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
          bottom: TabBar(tabs: [
            Tab(text: 'ACCOUNTS'),
            Tab(text: 'HISTORY'),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Accounts page goes here.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey,
              child: Center(
                child: Text(
                  'History page goes here.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            // go to calculator
          },
        ),
      ),
    );
  }
}
