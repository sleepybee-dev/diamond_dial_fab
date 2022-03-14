library diamond_dial_fab;

import 'package:flutter/material.dart';

class DiamondDialFab extends StatefulWidget {
  const DiamondDialFab(
      {Key? key,
        this.children = const [],
        this.mainIcon = const Icon(Icons.add),
        this.mainBackgroundColor,
        this.childBackgroundColor,
        this.childTextColor,
        this.childTextBackgroundColor,
        this.childLabelPosition,
        this.cornerRadius,
        this.dimOpacity}) : super(key: key);

  final List<FloatingActionButton> children;
  final Icon mainIcon;

  final Color? mainBackgroundColor;
  final Color? childBackgroundColor;
  final Color? childTextColor;
  final Color? childTextBackgroundColor;
  final LabelPosition? childLabelPosition;
  final double? cornerRadius;
  final double? dimOpacity;

  @override
  _DiamondDialFabState createState() => _DiamondDialFabState();

}

class _DiamondDialFabState extends State<DiamondDialFab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

enum LabelPosition { left, right }