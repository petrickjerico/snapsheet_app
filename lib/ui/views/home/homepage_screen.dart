import 'package:after_layout/after_layout.dart';
import 'package:animations/animations.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/business_logic/view_models/user_data/user_data_impl.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/ui/views/expense/add_record_fab_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/categories/category_screen.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HomepageScreen extends StatefulWidget {
  static GlobalKey bottomKey = GlobalKey();
  static final String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen>
    with AfterLayoutMixin<HomepageScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    if (userData.credentials['isDemo']) showDemoWelcome();
  }

  void showDemoWelcome() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          titlePadding: EdgeInsets.only(left: 20, right: 20, top: 20),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
          title: Text('Demo Mode'),
          content: Text("'Exit Demo' at the top right to start afresh"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ]),
    );
  }

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
        FilterData filterData = FilterData(userData);
        return Consumer<HomepageViewModel>(
          builder: (context, homepageModel, child) {
            return ChangeNotifierProvider.value(
              value: filterData,
              builder: (context, child) {
                return Scaffold(
                  extendBody: true,
                  resizeToAvoidBottomInset: false,
                  drawer: SidebarMenu(),
                  body: _pageList[HomepageViewModel.currentPage],
                  bottomNavigationBar: BottomAppBar(
                    key: HomepageScreen.bottomKey,
                    elevation: 10.0,
                    shape: CircularNotchedRectangle(),
                    notchMargin: 12,
                    clipBehavior: Clip.antiAlias,
                    child: BottomNavigationBar(
                      currentIndex: HomepageViewModel.currentBar,
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.4),
                      selectedItemColor:
                          Theme.of(context).colorScheme.onPrimary,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryVariant,
                      showUnselectedLabels: false,
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
                          icon: Icon(Icons.category),
                          title: Text('Categories'),
                        ),
                      ],
                      onTap: (index) {
                        if (index != 2) {
                          homepageModel.syncBarToPage(index);
                        }
                        if (index != 1) {
                          filterData.resetFilter();
                        }
                      },
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Consumer<HomepageViewModel>(
                    builder: (context, dashboardModel, child) {
                      return OpenContainer<bool>(
                        closedBuilder: (_, openContainer) {
                          return AddRecordFab(
                            onPressed: () {
                              int accountsCount =
                                  dashboardModel.accounts.length;
                              if (accountsCount < 1) {
                                Flushbar(
                                  message:
                                      "Cannot create record for no account.",
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28.0,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  duration: Duration(seconds: 3),
                                  leftBarIndicatorColor:
                                      Theme.of(context).colorScheme.secondary,
                                )..show(context);
                              } else {
                                model.newRecord();
                                int targetIndex = dashboardModel
                                        .getSelectedAccount()
                                        ?.index ??
                                    0;
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
                        openColor: Theme.of(context).colorScheme.background,
                        closedElevation: 10.0,
                        closedColor: Theme.of(context).colorScheme.primary,
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
      },
    );
  }
}
