import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/button/add_record_fab_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HomepageScreen extends StatelessWidget {
  static final String id = 'homepage_screen';

  final _titles = [
    'DASHBOARD',
    'HISTORY',
    'LIST OF ACCOUNTS',
    'EDIT PROFILE',
  ];

  final List<Widget> _pageList = <Widget>[
    Dashboard(),
    HistoryScreen(),
    EditAccountsOrder(),
    EditProfileScreen(),
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
              backgroundColor: Colors.black,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: kHomepageBackgroundTransparency,
                title: Text(_titles[homepageModel.currentPage]),
              ),
              drawer: SidebarMenu(),
              body: Container(
                color: kHomepageBackgroundTransparency,
                child: PageTransitionSwitcher(
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                      fillColor: Colors.transparent,
                    );
                  },
                  child: _pageList[homepageModel.currentPage],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 10.0,
                shape: CircularNotchedRectangle(),
                notchMargin: 12,
                clipBehavior: Clip.antiAlias,
                child: BottomNavigationBar(
                    currentIndex: homepageModel.currentBar,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        title: Text('Dashboard'),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.receipt),
                        title: Text('History'),
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
                          model.newRecord();
                          int targetIndex =
                              dashboardModel.getSelectedAccount()?.index ?? 0;
                          model.changeAccount(
                              targetIndex == -1 ? 0 : targetIndex);
                          openContainer.call();
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
