import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/date_time.dart';
import 'package:snapsheetapp/constants.dart';
import 'package:snapsheetapp/models/scanner.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';
import 'package:path/path.dart' as p;
import 'package:snapsheetapp/screens/editprofile_screen.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';

class EditInfoScreen extends StatefulWidget {
  static const String id = 'editinfo_screen';

  const EditInfoScreen({
    Key key,
  }) : super(key: key);

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  String title;
  UserData userData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var temp = title;
    setState(() {
      title = Provider.of<UserData>(context).tempRecord.title;
    });
    userData = Provider.of<UserData>(context);
    print('Title changed: $temp -> $title');
  }

  @override
  Widget build(BuildContext context) {
    print('EditInfoScreen build() called.');
//    return Consumer<UserData>(
//      builder: (context, userData, child) {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              RecordDateTime(),
              SizedBox(height: 10.0),
              userData.tempRecord.image == null
                  ? SizedBox.shrink()
                  : OutlineButton(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        p.basename(userData.tempRecord.image.path),
                        style: kStandardStyle,
                      ),
                      onPressed: () {
                        // View the receipt?
                      },
                    ),
              SizedBox(height: 10),
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.black,
                child: Text(
                  "Add Receipt",
                  style: kStandardStyle,
                ),
                onPressed: () {
                  Scanner scanner =
                      Scanner(userData: userData, screenId: EditInfoScreen.id);
                  setState(() async {
                    await scanner.process(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, EditInfoScreen.id);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.check),
        onPressed: () {
          print("Adding to record: \$${userData.tempRecord.value}");
          userData.addRecord();
          Navigator.popUntil(
            context,
            ModalRoute.withName(HomepageScreen.id),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
//      },
//    );
  }
}
