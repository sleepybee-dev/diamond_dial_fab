import 'package:diamond_dial_fab/diamond_dial_fab.dart';
import 'package:flutter/material.dart';

class AnimatedChild extends AnimatedWidget {
  final int? index;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Size buttonSize;
  final Widget? child;
  final List<BoxShadow>? labelShadow;
  final Key? btnKey;

  final String? label;
  final TextStyle? labelStyle;
  final Color? labelBackgroundColor;
  final Widget? labelWidget;

  final bool visible;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? toggleChildren;
  final ShapeBorder? shapeBorder;
  final String? heroTag;
  final LabelLocation? labelLocation;
  // final EdgeInsets? margin;

  const AnimatedChild({
    Key? key,
    this.btnKey,
    required Animation<double> animation,
    this.index,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.buttonSize = const Size(56.0, 56.0),
    this.child,
    this.label,
    this.labelStyle,
    this.labelShadow,
    this.labelBackgroundColor,
    this.labelWidget,
    this.visible = true,
    this.onTap,
    required this.labelLocation,
    // required this.margin,
    this.onLongPress,
    this.toggleChildren,
    this.shapeBorder,
    this.heroTag,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    bool dark = Theme.of(context).brightness == Brightness.dark;

    void _performAction([bool isLong = false]) {
      if (onTap != null && !isLong) {
        onTap!();
      } else if (onLongPress != null && isLong) {
        onLongPress!();
      }
      toggleChildren!();
    }

    Widget buildLabel() {
      if (label == null && labelWidget == null) return Container();

      if (labelWidget != null) {
        return GestureDetector(
          onTap: _performAction,
          onLongPress: () => _performAction(true),
          child: labelWidget,
        );
      }

      return GestureDetector(
        onTap: _performAction,
        onLongPress: () => _performAction(true),
        child: Container(
          alignment: labelLocation == LabelLocation.left ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: labelBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              boxShadow: labelShadow,
            ),
            child: Text(label!, style: labelStyle),
          ),
        ),
      );
    }

    Widget button = ScaleTransition(
        scale: animation,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: FloatingActionButton(
            key: btnKey,
            heroTag: heroTag,
            onPressed: _performAction,
            backgroundColor: backgroundColor ?? Colors.white,
            foregroundColor: foregroundColor ?? (dark ? Colors.white : Colors.black),
            elevation: elevation ?? 0.0,
            child: child,
            shape: shapeBorder,
          ),
        ));

    List<Widget> children = [
      if (label != null || labelWidget != null)
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            key: (child == null) ? btnKey : null,
            child: labelLocation == LabelLocation.left ? buildLabel() : null,
          ),
        ),
      if (child != null)
        Container(
          height: buttonSize.height,
          width: buttonSize.width,
          child: (onLongPress == null)
              ? button
              : FittedBox(
            child: GestureDetector(
              onLongPress: () => _performAction(true),
              child: button,
            ),
          ),
        ),
      Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: labelLocation == LabelLocation.right ? buildLabel() : null,
      ))
    ];

    Widget _buildColumnOrRow(
        {CrossAxisAlignment? crossAxisAlignment,
          MainAxisAlignment? mainAxisAlignment,
          required List<Widget> children,
          MainAxisSize? mainAxisSize}) {
      return Container(
        child: Row(
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment:
          crossAxisAlignment ?? CrossAxisAlignment.center,
          children: children,
        ),
      );
    }

    return visible
        ? Container(
      // margin: margin,
      child: _buildColumnOrRow(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    )
        : Container();
  }
}