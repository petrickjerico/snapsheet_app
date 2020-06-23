import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HomepageScreen extends StatefulWidget {
  static final String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ChangeNotifierProvider<ExpenseViewModel>(
      create: (context) => ExpenseViewModel(user),
      child: Scaffold(
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
              final model = Provider.of<ExpenseViewModel>(context);
              model.setTempRecord(Record.newBlankRecord());
              Navigator.pushNamed(context, ExpenseScreen.id);
            },
          ),
        )
      );
  }
}
