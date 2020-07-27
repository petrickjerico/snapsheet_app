import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class DeleteConfirmButton extends StatelessWidget {
  final bool isDelete;
  final Function callBack;

  DeleteConfirmButton({this.isDelete, this.callBack});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                  height: 40,
                  color: isDelete ? Colors.red.withOpacity(0.3) : kGrey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(FontAwesomeIcons.trashAlt,
                          color: isDelete
                              ? Colors.red
                              : Theme.of(context).colorScheme.background),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Delete',
                          style: TextStyle(
                              color: isDelete
                                  ? Colors.red
                                  : Theme.of(context).colorScheme.background))
                    ],
                  ),
                ),
                onTap: isDelete ? () => {} : () => callBack(),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  height: 40,
                  color: !isDelete ? Colors.tealAccent.withOpacity(0.3) : kGrey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        color: !isDelete
                            ? Colors.teal
                            : Theme.of(context).colorScheme.background,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Add',
                          style: TextStyle(
                              color: !isDelete
                                  ? Colors.teal
                                  : Theme.of(context).colorScheme.background))
                    ],
                  ),
                ),
                onTap: !isDelete ? () => {} : () => callBack(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
