import 'package:animations/animations.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/button/add_record_fab_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/categories/category_screen.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HomepageScreen extends StatelessWidget {
  static GlobalKey bottomKey = GlobalKey();
  static final String id = 'homepage_screen';

  final _titles = [
    'DASHBOARD',
    'RECORDS',
    'LIST OF ACCOUNTS',
    'EDIT CATEGORIES',
  ];

  final List<Widget> _pageList = <Widget>[
    Dashboard(),
    HistoryScreen(),
    EditAccountsOrder(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Consumer<ExpenseViewModel>(
      builder: (context, model, child) {
        model.userData = userData;
        return Consumer<HomepageViewModel>(
          builder: (context, homepageModel, child) {
            return Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: false,
              drawer: SidebarMenu(),
              body: _pageList[HomepageViewModel.currentPage],
              bottomNavigationBar: BottomAppBar(
                key: bottomKey,
                elevation: 10.0,
                shape: CircularNotchedRectangle(),
                notchMargin: 12,
                clipBehavior: Clip.antiAlias,
                child: BottomNavigationBar(
                    currentIndex: HomepageViewModel.currentBar,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: false,
                    selectedItemColor: kBlack,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        title: Text('Dashboard'),
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesomeIcons.stream,
                          size: 18,
                        ),
                        title: Text('Records'),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add),
                        title: Text(''),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.credit_card),
                        title: Text('Accounts'),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        title: Text('Profile'),
                      ),
                    ],
                    onTap: (index) {
                      if (index != 2) {
                        homepageModel.syncBarToPage(index);
                      }
                    }),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Consumer<HomepageViewModel>(
                builder: (context, dashboardModel, child) {
                  return OpenContainer<bool>(
                    closedBuilder: (_, openContainer) {
                      return AddRecordFab(
                        onPressed: () {
                          int accountsCount = dashboardModel.accounts.length;
                          if (accountsCount < 1) {
                            Flushbar(
                              message: "Cannot create record for no account.",
                              icon: Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: Colors.blue[300],
                              ),
                              duration: Duration(seconds: 3),
                              leftBarIndicatorColor: Colors.blue[300],
                            )..show(context);
                          } else {
                            model.newRecord();
                            int targetIndex =
                                dashboardModel.getSelectedAccount()?.index ?? 0;
                            model.changeAccount(
                                targetIndex == -1 ? 0 : targetIndex);
                            openContainer.call();
                          }
                        },
                      );
                    },
                    openBuilder: (_, openContainer) {
                      return ExpenseScreen();
                    },
                    closedElevation: 8,
                    closedColor: kBlack,
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    transitionType: ContainerTransitionType.fade,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
