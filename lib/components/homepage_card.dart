import 'package:flutter/material.dart';

class HomepageCard extends StatelessWidget {
  HomepageCard({@required this.cardChild});

  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Center(
        child: cardChild,
      ),
    );
  }
}
