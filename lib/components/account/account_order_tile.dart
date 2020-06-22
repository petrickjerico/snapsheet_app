import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/home/rename_account_popup.dart';

class AccountOrderTile extends StatefulWidget {
  AccountOrderTile(
      {Key key, this.index, this.color, this.title, this.count, this.total})
      : super(key: key);

  int index;
  Color color;
  String title;
  int count;
  double total;

  @override
  _AccountOrderTileState createState() => _AccountOrderTileState();
}

class _AccountOrderTileState extends State<AccountOrderTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) => ListTile(
//        onTap: () {
//          setState(() {
//            userData.selectAccount(widget.index);
//          });
//          Navigator.pop(context);
//        },
        dense: true,
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(5.0)),
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.total.toStringAsFixed(2),
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        trailing: Theme(
          data: ThemeData.light(),
          child: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: () => rename(),
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: () => delete(),
                child: Text('Delete'),
              ),
            ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (Function value) {
              userData.selectAccount(widget.index);
              value.call();
            },
          ),
        ),
      ),
    );
  }

  void rename() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Consumer<UserData>(
        builder: (context, userData, child) => SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: RenameAccountPopup(),
        ),
      ),
    );
  }

  void delete() {
    showDialog(
      context: context,
      builder: (context) => Consumer<UserData>(
        builder: (context, userData, child) => Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            titlePadding: EdgeInsets.only(left: 20, right: 20, top: 20),
            contentPadding:
                EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            title: Text("Delete account?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete ${userData.accounts[userData.selectedAccount].title}?',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'DELETE',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () {
                        userData.deleteAccount();
                        Navigator.pop(context);
                      },
                    ),
                    OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text('NO'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//  Future<void> showChoiceDialog(BuildContext context) {
//    UserData userData = Provider.of<UserData>(context, listen: false);
//    return showDialog(
//      context: context,
//      builder: (context) {
//        return PopupMenuButton(
//          title: Text("Select"),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                GestureDetector(
//                  child: Text("Edit"),
//                  onTap: () {
//                    Navigator.pop(context);
//                    showModalBottomSheet(
//                      context: context,
//                      isScrollControlled: true,
//                      builder: (context) => SingleChildScrollView(
//                        padding: EdgeInsets.only(
//                            bottom: MediaQuery.of(context).viewInsets.bottom),
//                        child: RenameAccountPopup(userData.selectedAccount),
//                      ),
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(30.0),
//                          topRight: Radius.circular(30.0),
//                        ),
//                      ),
//                    );
//                  },
//                ),
//                SizedBox(height: 20),
//                GestureDetector(
//                  child: Text("Delete"),
//                  onTap: () {
//                    Navigator.pop(context);
//                    showDialog(
//                      context: context,
//                      builder: (context) => AlertDialog(
//                        titlePadding:
//                            EdgeInsets.only(left: 20, right: 20, top: 20),
//                        contentPadding: EdgeInsets.only(
//                            left: 20, right: 20, top: 20, bottom: 10),
//                        title: Text("Delete account?"),
//                        content: Column(
//                          mainAxisSize: MainAxisSize.min,
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Text(
//                              'Are you sure you want to delete ${userData.accounts[userData.selectedAccount].title}?',
//                            ),
//                            SizedBox(
//                              height: 10,
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                FlatButton(
//                                  child: Text(
//                                    'DELETE',
//                                    style: TextStyle(color: Colors.white),
//                                  ),
//                                  color: Colors.black,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(5.0)),
//                                  onPressed: () {
//                                    userData.deleteAccount(
//                                        userData.selectedAccount);
//                                    Navigator.pop(context);
//                                  },
//                                ),
//                                OutlineButton(
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(5.0)),
//                                  child: Text('NO'),
//                                  onPressed: () {
//                                    Navigator.pop(context);
//                                  },
//                                ),
//                              ],
//                            )
//                          ],
//                        ),
//                      ),
//                    );
//                  },
//                )
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
}
