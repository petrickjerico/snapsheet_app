import 'package:flutter/material.dart';

import '../constants.dart';

class AddCategoryScreen extends StatelessWidget {
  static const String id = 'addcategory_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
          child: Text(
        'Lists of category will appear here.',
        style: TextStyle(fontStyle: FontStyle.italic),
      )),
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
  }
}

class AddCategoryPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  //Do something with the user input.
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
  }
}
