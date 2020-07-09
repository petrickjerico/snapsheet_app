import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';

class StatsCard extends StatefulWidget {
  StatsCard({
    @required this.title,
    @required this.colour,
    @required this.child,
  });

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
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(color: widget.colour),
          borderRadius: BorderRadius.circular(10.0),
        ),
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
                    style: TextStyle(
                        fontSize: 18,
                        color: widget.colour,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  thickness: 1,
                  color: widget.colour,
                ),
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
      );
    });
  }
}
