import 'package:flutter/material.dart';

class DiamondDialChild {

  final Key? key;
  final String? label;
  final List<BoxShadow>? labelShadow;
  final TextStyle? labelStyle;
  final Color? labelBackgroundColor;
  final Widget? labelWidget;
  final Widget? child;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onTap;
  final ShapeBorder? shapeBorder;

  DiamondDialChild({
      this.key,
      this.label,
      this.labelShadow,
      this.labelStyle,
      this.labelBackgroundColor,
      this.labelWidget,
      this.child,
      this.foregroundColor,
      this.backgroundColor,
      this.elevation,
      this.onTap,
      this.shapeBorder});


}