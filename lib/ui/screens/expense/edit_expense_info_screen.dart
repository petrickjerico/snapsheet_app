import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EditExpenseInfoScreen extends StatefulWidget {
  static const String id = 'edit_expense_info_screen';

  const EditExpenseInfoScreen({
    Key key,
  }) : super(key: key);

  @override
  _EditExpenseInfoScreenState createState() => _EditExpenseInfoScreenState();
}

class _EditExpenseInfoScreenState extends State<EditExpenseInfoScreen> {
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
      backgroundColor: kBlack,
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
                  Scanner scanner = Scanner.withUserData(userData);
                  await scanner.showChoiceDialog(context);
                  await scanner.process();
                  setState(() {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, EditExpenseInfoScreen.id);
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
