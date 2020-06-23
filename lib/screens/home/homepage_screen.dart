// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/config/config.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/calculator/addexpenses_screen.dart';
import 'package:snapsheetapp/screens/home/accounts_tab.dart';
import 'package:snapsheetapp/screens/sidebar/addcategory_screen.dart';
import 'package:snapsheetapp/screens/sidebar/sidebar_menu.dart';
import 'package:snapsheetapp/screens/wrapper.dart';
import 'package:snapsheetapp/services/auth.dart';
import 'package:snapsheetapp/services/scanner.dart';

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
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.lightBlueAccent,
          overlayColor: Colors.black,
          overlayOpacity: 0.75,
          child: Icon(Icons.add),
          children: [
            SpeedDialChild(
              backgroundColor: kBlack,
              label: 'Calculator',
              child: OpenContainer(
                transitionType: ContainerTransitionType.fade,
                closedColor: kBlack,
                closedShape: CircleBorder(),
                openBuilder: (context, _) {
                  userData.newRecord();
                  return AddExpensesScreen();
                },
                closedBuilder: (context, _) => Icon(
                  FontAwesomeIcons.calculator,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SpeedDialChild(
                label: 'Receipt',
                backgroundColor: kCyan.withOpacity(0.9),
                child: Icon(Icons.receipt),
                onTap: () async {
                  userData.newRecord();
                  Scanner scanner = Scanner.withUserData(userData);
                  await scanner.showChoiceDialog(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      print('Loading screen showing...');
                      return Dialog(
                        child: Container(
                          height: 100,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text('Loading receipt...')
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  await scanner.process();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AddExpensesScreen.id);
                }),
          ],
        ),
      );
    });
  }
}
