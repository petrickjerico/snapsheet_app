import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_viewmodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/business_logic/view_models/user_data/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/export/export_list.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class ExportScreen extends StatelessWidget {
  static const String id = 'export_screen';
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        leading: BackButton(),
        title: Text('Select Accounts to Export'),
      ),
      body: ChangeNotifierProvider<ExportViewModel>(
        create: (context) => ExportViewModel(userData: userData),
        child: Consumer<ExportViewModel>(
          builder: (context, model, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(child: ExportList()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DateDisplay(isStart: true),
                      Icon(FontAwesomeIcons.arrowsAltH),
                      DateDisplay(isStart: false),
                    ],
                  ),
                  RoundedButton(
                    textColor: Colors.white,
                    color: kNavyBluePrimary,
                    title: 'Export',
                    icon: Icon(
                      Icons.import_export,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await model.exportCSV();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DateDisplay extends StatelessWidget {
  bool isStart;

  DateDisplay({this.isStart});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExportViewModel>(builder: (context, model, child) {
      DateTime date = isStart ? model.start : model.end;
      return Column(
        children: <Widget>[
          Text(isStart ? "Start" : "End"),
          OutlineButton(
              padding: EdgeInsets.all(10.0),
              child: Text(
                DateFormat.yMMMd().format(date),
                style: kDateTextStyle,
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
                  model.changeDate(
                      isStart,
                      DateTime(
                        value.year,
                        value.month,
                        value.day,
                      ));
                });
              }),
        ],
      );
    });
  }
}
