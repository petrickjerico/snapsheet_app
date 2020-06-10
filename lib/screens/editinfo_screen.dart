import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';
import 'package:path/path.dart' as p;

class EditInfoScreen extends StatefulWidget {
  static const String id = 'editinfo_screen';

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        DateTime date = userData.tempRecord.date;
        String title = userData.tempRecord.title;
        return Scaffold(
          backgroundColor: Colors.blueGrey,
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
            title: Text('EDIT INFORMATION'),
          ),
          body: Theme(
            data: ThemeData.dark(),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Title",
                    ),
                    onChanged: (value) {
                      setState(() {
                        userData.changeTitle(value);
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.calendarAlt,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Date',
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('d/M/y').format(date),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(date.year - 5),
                                lastDate: DateTime(date.year + 5),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.dark(),
                                    child: child,
                                  );
                                },
                              ).then((value) {
                                setState(() {
                                  userData.changeDate(DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    date.hour,
                                    date.minute,
                                  ));
                                });
                              });
                            }),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: OutlineButton(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.clock),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Time',
                                        style: TextStyle(
                                            color: Colors.blueGrey[200],
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        DateFormat('Hm').format(date),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: date.hour,
                                  minute: date.minute,
                                ),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.dark(),
                                    child: child,
                                  );
                                },
                              ).then((value) {
                                setState(() {
                                  userData.changeDate(DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    value.hour,
                                    value.minute,
                                  ));
                                });
                              });
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  userData.tempRecord.image == null
                      ? SizedBox.shrink()
                      : Expanded(
                          child: OutlineButton(
                            padding: EdgeInsets.all(10),
                            child: Text(
                                p.basename(userData.tempRecord.image.path)),
                            onPressed: () {
                              // View the receipt?
                            },
                          ),
                        ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.check),
            onPressed: () {
              //TODO: more complex navigation
              Navigator.popUntil(
                context,
                ModalRoute.withName(AddExpensesScreen.id),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 40.0,
              child: Container(
                child: null,
              ),
            ),
          ),
        );
      },
    );
  }
}
