import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/dialog/delete_dialog.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/home/rename_account_popup.dart';

class AccountOrderTile extends StatelessWidget {
  final int index;
  final Color color;
  final String title;
  final double total;
  final bool isSelectAccountScreen;

  AccountOrderTile(
      {this.index,
      this.color,
      this.title,
      this.total,
      this.isSelectAccountScreen});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomepageViewModel>(context, listen: false);
    return ListTile(
      onTap: () {
        if (isSelectAccountScreen) {
          Navigator.pop(context, index);
        } else {
          model.selectAccount(index);
          HomepageViewModel.syncController();
          HomepageViewModel.syncBarAndTabToBeginning();
        }
      },
      contentPadding: EdgeInsets.only(left: 20),
      dense: true,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.0)),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        total.toStringAsFixed(2),
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      trailing: Theme(
          data: ThemeData.light(),
          child: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () {
                    model.initEditAccount(index);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: RenameAccountPopup(),
                      ),
                      shape: kBottomSheetShape,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    model.selectAccount(index);
                    showDialog(
                      context: context,
                      child: DeleteDialog(
                          title: 'Delete Account?',
                          message: 'Are you sure you want to delete ${title}?',
                          onDelete: () {
                            model.deleteAccount();
                            HomepageViewModel.syncController();
                            Navigator.pop(context);
                          }),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
