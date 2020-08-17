import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';

class StatsCard extends StatefulWidget {
  StatsCard({
    Key key,
    @required this.title,
    @required this.colour,
    @required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Color colour;

  @override
  _StatsCardState createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  @override
  Widget build(BuildContext context) {
    var horizontalPadding = EdgeInsets.symmetric(horizontal: 15.0);
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: horizontalPadding,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: horizontalPadding,
                  child: Container(
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
