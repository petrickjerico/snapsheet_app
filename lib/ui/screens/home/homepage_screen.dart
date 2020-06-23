import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HomepageScreen extends StatefulWidget {
  static final String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
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
        drawer: SidebarMenu(),
        body: PageView(
          children: <Widget>[
            AccountsTab(),
            HistoryTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBlack,
          child: Icon(Icons.add),
          onPressed: () {
            userData.newRecord();
            Navigator.pushNamed(context, AddE xpensesScreen.id);
          },
        ),
      );
    });
  }
}
