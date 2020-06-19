import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/date_time.dart';
import 'package:snapsheetapp/components/receipt_image_dialog.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/home/homepage_screen.dart';
import 'package:snapsheetapp/services/scanner.dart';
import 'package:snapsheetapp/shared/constants.dart';

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
    title = Provider.of<UserData>(context).tempRecord.title;
    userData = Provider.of<UserData>(context);
    print('Title changed: $temp -> $title');
  }

  @override
  Widget build(BuildContext context) {
    print('EditInfoScreen build() called.');
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
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
                  : GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) =>
                                ReceiptImageDialog(userData.tempRecord.image));
                      },
                      child: Image.file(
                        userData.tempRecord.image,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
              SizedBox(height: 10),
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.black,
                child: Text(
                  "Add Receipt",
                  style: kStandardStyle,
                ),
                onPressed: () async {
                  Scanner scanner = Scanner(userData);
                  await scanner.showChoiceDialog(context);
                  await scanner.process();
                  setState(() {
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
