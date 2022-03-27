library diamond_dial_fab;

import 'package:diamond_dial_fab/animated_floating_button.dart';
import 'package:flutter/material.dart';

class DiamondDialFab extends StatefulWidget {

  final List<FloatingActionButton> children;

  /// <mainIcon> The icon of the main floating button.
  final IconData mainIcon;

  final Color? mainBackgroundColor;
  final Color? mainForegroundColor;
  final Color? childBackgroundColor;
  final Color? childTextColor;
  final Color? childTextBackgroundColor;
  final LabelPosition? childLabelPosition;
  final double? cornerRadius;
  final double? dimOpacity;
  final int animationSpeed;

  final ValueNotifier<bool>? notifierIsOpen;

  bool _isOpen = false;
  bool _isOverlayRendered = false;

  DiamondDialFab(
      {Key? key,
        this.children = const [],
        this.mainIcon = Icons.add,
        this.mainBackgroundColor,
        this.mainForegroundColor,
        this.childBackgroundColor,
        this.childTextColor,
        this.childTextBackgroundColor,
        this.childLabelPosition,
        this.cornerRadius,
        this.dimOpacity,
        this.animationSpeed = 100,
        this.notifierIsOpen,}) : super(key: key);


  @override
  _DiamondDialFabState createState() => _DiamondDialFabState();

}

class _DiamondDialFabState extends State<DiamondDialFab> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: widget.animationSpeed));
  bool _isOpen = false;
  OverlayEntry? overlayEntry;
  OverlayEntry? backgroundOverlayEntry;
  final LayerLink _layerLink = LayerLink();
  final dialKey = GlobalKey<State<StatefulWidget>>();


  @override
  void initState() {
    super.initState();
    widget.notifierIsOpen?.addListener(() => _onIsOpenNotified);
  }

  void _onIsOpenNotified() {
    final isOpen = widget.notifierIsOpen?.value;
    if (_isOpen != isOpen) {
      _toggleChildren();
    }
  }

  void _toggleChildren() {
    if (!mounted) return;

    if(widget.children.isNotEmpty) {
      var newValue = !_isOpen;
      toggleOverlay();
      if (widget.notifierIsOpen != null) widget.notifierIsOpen!.value = newValue;

    }
  }

  void toggleOverlay() {
    if (_isOpen) {
      _animationController.reverse().whenComplete((){
        overlayEntry?.remove();
        if (widget._isOverlayRendered && backgroundOverlayEntry!.mounted) {
          backgroundOverlayEntry?.remove();
        }
      });
    } else {
      if (_animationController.isAnimating) {
        return;
      }
      overlayEntry = OverlayEntry(
          builder: (builder) => Stack(
            fit: StackFit.loose,
            children: [
              Positioned(child: CompositedTransformFollower(
                followerAnchor: Alignment.center,
                link: _layerLink,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    child: _buildDials(),
                  ),
                ),
              ))
            ],
          )
      );
    }

    if (!mounted) return;
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  Widget _buildDials() {
    return Column(
      children: widget.children
    );
  }

  Widget _renderFAB() {
     var child = AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? _widget) =>
        Transform.rotate(
            angle: 0,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: widget.animationSpeed),
              child: Container(
                child: Center(
                  child: Icon(
                    widget.mainIcon,
                    key: const ValueKey<int>(1),
                    size: 20,
                  ),
                ),
              ),
            ),)
    );

     var animatedFloatingButton = AnimatedBuilder(
         animation: _animationController,
         builder: (context, ch) => CompositedTransformTarget(
           link: _layerLink,
           key: dialKey,
            child: AnimatedFloatingButton(
              backgroundColor: widget.mainBackgroundColor,
              foregroundColor: widget.mainForegroundColor,
              onLongPress: _toggleChildren,
              child: child,
            ),));

     return animatedFloatingButton;
  }

  @override
  Widget build(BuildContext context) {
    return _renderFAB();
  }

}

enum LabelPosition { left, right }