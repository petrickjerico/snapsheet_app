import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';
import 'package:snapsheetapp/ui/views/accounts/rename_account_popup.dart';

class AccountOrderTile extends StatelessWidget {
  final BuildContext context;
  final int index;
  final Color color;
  final String title;
  final double total;
  final bool isSelectAccountScreen;

  AccountOrderTile(
      {this.context,
      this.index,
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
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: Text(
        total.toStringAsFixed(2),
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 18,
            ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).iconTheme.color,
              ),
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
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                model.selectAccount(index);
                showDialog(
                  context: this.context,
                  child: DeleteDialog(
                      title: 'Delete Account',
                      message:
                          'This will delete all records in this account.\nAre you sure you want to delete ${title}?',
                      onDelete: () {
                        model.deleteAccount();
                        Navigator.of(this.context).pop();
                        HomepageViewModel.syncController();
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
