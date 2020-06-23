import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/export/export_list.dart';

class ExportScreen extends StatelessWidget {
  static const String id = 'export_screen';
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return ChangeNotifierProvider<ExportViewModel>(
        create: (context) => ExportViewModel(userData: userData),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(),
            title: Text('EXPORT SELECTIONS'),
          ),
          body: Consumer<ExportViewModel>(
            builder: (context, model, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ExportList(),
                  RoundedButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    title: 'Export',
                    icon: Icon(Icons.import_export),
                    onPressed: () {
                      model.exportCSV();
                    },
                  )
                ],
              );
            },
          ),
        ));
  }
}
