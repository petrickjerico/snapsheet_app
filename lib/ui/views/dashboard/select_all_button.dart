import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class SelectAllButton extends StatelessWidget {
  const SelectAllButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, model, child) => Visibility(
        visible: model.accounts.length > 1 &&
            HomepageViewModel.selectedAccountIndex != -1,
        child: MaterialButton(
          visualDensity: VisualDensity.compact,
          minWidth: 100,
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: kNavyBluePrimary),
          ),
          textColor: kNavyBluePrimary,
          child: Text('SELECT ALL'),
          onPressed: () {
            model.selectAccount(-1);
          },
        ),
      ),
    );
  }
}
