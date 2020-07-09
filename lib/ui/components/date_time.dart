import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';

class RecordDateTime extends StatefulWidget {
  @override
  _RecordDateTimeState createState() => _RecordDateTimeState();
}

class _RecordDateTimeState extends State<RecordDateTime> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseViewModel>(
      builder: (context, model, child) {
        DateTime date = model.tempRecord.dateTime;
        return Row(
          children: <Widget>[
            Expanded(
              child: OutlineButton(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.calendarAlt),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        model.changeDate(DateTime(
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
            SizedBox(width: 10.0),
            Expanded(
              child: OutlineButton(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.clock),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        model.changeDate(DateTime(
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
        );
      },
    );
  }
}
