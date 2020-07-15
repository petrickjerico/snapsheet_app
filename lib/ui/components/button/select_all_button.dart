import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

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
          visualDensity: VisualDensity.comfortable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: kDarkCyan),
          ),
          child: Text(
            'SELECT ALL',
            style: TextStyle(
              color: kDarkCyan,
            ),
          ),
          onPressed: () {
            model.selectAccount(-1);
          },
        ),
      ),
    );
  }
}
