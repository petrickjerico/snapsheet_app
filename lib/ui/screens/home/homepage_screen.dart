import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
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
    final userData = Provider.of<UserData>(context, listen: false);
    return ChangeNotifierProvider<ExpenseViewModel>(
        create: (context) => ExpenseViewModel(userData: userData),
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
              final model =
                  Provider.of<ExpenseViewModel>(context, listen: false);
              model.newRecord();
              Navigator.pushNamed(context, ExpenseScreen.id);
            },
          ),
        ));
  }
}
