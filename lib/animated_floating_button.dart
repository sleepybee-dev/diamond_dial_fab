import 'package:diamond_dial_fab/diamond_border.dart';
import 'package:flutter/material.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final VoidCallback? callback;
  final VoidCallback? onLongPress;
  final Widget? label;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;
  final String? heroTag;
  final double elevation;
  final double size;
  final ShapeBorder shape;
  final Curve curve;
  final Widget? dialRoot;
  final bool useInkWell;

  const AnimatedFloatingButton({
    Key? key,
    this.callback,
    this.label,
    this.child,
    this.dialRoot,
    this.useInkWell = false,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.heroTag,
    this.elevation = 6.0,
    this.size = 56.0,
    this.shape = const CircleBorder(),
    this.curve = Curves.fastOutSlowIn,
    this.onLongPress,
  }) : super(key: key);

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.dialRoot == null
        ? AnimatedContainer(
      curve: widget.curve,
      duration: const Duration(milliseconds: 150),
      height: widget.size,
      child: FittedBox(
        child: GestureDetector(
          onLongPress: widget.onLongPress,
          child: widget.label != null
              ? FloatingActionButton.extended(
            icon: widget.child,
            label: widget.label!,
            shape: widget.shape,
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.foregroundColor,
            onPressed: widget.callback,
            tooltip: widget.tooltip,
            heroTag: widget.heroTag,
            elevation: widget.elevation,
            highlightElevation: widget.elevation,
          )
              : FloatingActionButton(
            child: widget.child,
            shape: widget.shape,
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.foregroundColor,
            onPressed: widget.callback,
            tooltip: widget.tooltip,
            heroTag: widget.heroTag,
            elevation: widget.elevation,
            highlightElevation: widget.elevation,
          ),
        ),
      ),
    )
        : AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: widget.curve,
      child: widget.dialRoot,
    );
  }
}
