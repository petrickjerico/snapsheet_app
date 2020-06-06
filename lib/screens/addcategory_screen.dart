import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';

import '../constants.dart';

class AddCategoryScreen extends StatelessWidget {
  static const String id = 'addcategory_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: FlatButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO: more complex navigation
              Navigator.pop(context);
            },
          ),
          title: Text('CATEGORIES'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: userData.categoriesCount,
            itemBuilder: (context, index) {
              return ListTile(
                leading: userData.categoryIcons[index],
                title: Text(userData.categoryTitles[index]),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddCategoryPopup(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class AddCategoryPopup extends StatelessWidget {
  String categoryTitle;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 10.0),
                TextField(
                  autofocus: true,
                  onChanged: (value) {
                    categoryTitle = value;
                  },
                  decoration: kTextFieldDecorationLogin.copyWith(
                      hintText: 'Name your new category'),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Container(
              height: 50.0,
              width: 150.0,
              child: FlatButton(
                color: Colors.black,
                child: Text(
                  'CREATE',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  userData.addCategory(categoryTitle, Icon(Icons.category));
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      );
    });
  }
}
