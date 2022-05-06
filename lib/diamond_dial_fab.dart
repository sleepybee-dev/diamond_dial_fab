library diamond_dial_fab;

import 'dart:math';

import 'package:diamond_dial_fab/animated_floating_button.dart';
import 'package:diamond_dial_fab/background_overlay.dart';
import 'package:diamond_dial_fab/diamond_border.dart';
import 'package:diamond_dial_fab/diamond_dial_fab_child.dart';
import 'package:flutter/material.dart';

import 'global_key_extension.dart';

import 'animated_child.dart';

class DiamondDialFab extends StatefulWidget {

  final List<DiamondDialChild> children;

  final double buttonSize;

  final Icon mainIcon;
  final Icon? pressedIcon;

  final Color? mainBackgroundColor;
  final Color? pressedBackgroundColor;

  final Color? mainForegroundColor;
  final Color? pressedForegroundColor;

  final LabelLocation? childLabelLocation;
  final double? cornerRadius;
  final DimOverlay dimOverlay;
  final double? dimOpacity;
  final int animationSpeed;

  final Size childrenButtonSize;

  final ValueNotifier<bool>? notifierIsOpen;

  bool _isOpen = false;
  bool _isOverlayRendered = false;

  final String? heroTag;

  DiamondDialFab(
      {Key? key,
        required this.children,
        this.buttonSize = 64.0,
        this.mainIcon = const Icon(Icons.add),
        this.mainBackgroundColor,
        this.mainForegroundColor,
        this.pressedIcon,
        this.pressedBackgroundColor,
        this.pressedForegroundColor,
        this.childLabelLocation,
        this.cornerRadius = 2.0,
        this.dimOverlay = DimOverlay.none,
        this.dimOpacity = 0.7,
        this.childrenButtonSize = const Size(56.0, 56.0),
        this.notifierIsOpen,
        this.heroTag,
        this.animationSpeed = 1000,}) : super(key: key);


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
  Icon? _curMainIcon;
  Color? _curBackgroundColor;
  Color? _curForegroundColor;

  @override
  void initState() {
    super.initState();
    widget.notifierIsOpen?.addListener(() => _onIsOpenNotified);
    _curMainIcon = widget.mainIcon;
    _curBackgroundColor = widget.mainBackgroundColor;
    _curForegroundColor = widget.mainForegroundColor;
  }

  @override
  void dispose() {
    if (backgroundOverlayEntry != null && backgroundOverlayEntry!.mounted)
      backgroundOverlayEntry?.remove();

    overlayEntry?.dispose();
    super.dispose();
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
      toggleMainIcon();
      if (widget.notifierIsOpen != null) widget.notifierIsOpen!.value = newValue;

    }
  }

  void toggleOverlay() {
    if (_isOpen) {
      _animationController.reverse().whenComplete((){
        overlayEntry?.remove();
        if (backgroundOverlayEntry != null && backgroundOverlayEntry!.mounted) {
          backgroundOverlayEntry?.remove();
        }
      });
    } else {
      if (_animationController.isAnimating) {
        return;
      }
      overlayEntry = OverlayEntry(
          builder: (context) =>
              _ChildrenOverlay(
                widget: widget,
                dialKey: dialKey,
                layerLink: _layerLink,
                toggleChildren: _toggleChildren,
                animationController: _animationController,
              )
      );

      backgroundOverlayEntry = widget.dimOverlay == DimOverlay.none ? null : OverlayEntry(
          builder: (context) {
            bool _shouldDark = widget.dimOverlay == DimOverlay.dark;
            return BackgroundOverlay(
              shape: DiamondBorder(
                cornerRadius: widget.cornerRadius ?? 2.0
              ),
              animation: _animationController,
              dialKey: dialKey,
              layerLink: _layerLink,
              onTap: _toggleChildren,
              opacity: widget.dimOpacity ?? 1,
              color: _shouldDark ? Colors.black : Colors.white,);
          });

      _animationController.forward();
      if (widget.dimOverlay != DimOverlay.none) {
        Overlay.of(context)!.insert(backgroundOverlayEntry!);
      }
      Overlay.of(context)!.insert(overlayEntry!);
    }

    if (!mounted) return;
    setState(() {
      _isOpen = !_isOpen;
    });
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
                  child: _curMainIcon
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
              size: widget.buttonSize,
              shape: DiamondBorder(
                cornerRadius: widget.cornerRadius! >= widget.buttonSize / 4.0 ? widget.buttonSize / 4.0 : widget.cornerRadius!
              ),
              backgroundColor: _curBackgroundColor,
              foregroundColor: _curForegroundColor,
              callback: _toggleChildren,
              child: child,
              heroTag: widget.heroTag,
            )));

     return animatedFloatingButton;
  }

  @override
  Widget build(BuildContext context) {
    return _renderFAB();
  }

  void toggleMainIcon() {
    if (widget.pressedIcon != null) {
      setState(() {
        if (widget.pressedIcon != null) {
          _curMainIcon = _isOpen ? widget.pressedIcon : widget.mainIcon;
        }
        if (widget.pressedBackgroundColor != null) {
          _curBackgroundColor = _isOpen ? widget.pressedBackgroundColor : widget.mainBackgroundColor;
        }
        if (widget.pressedForegroundColor != null) {
          _curForegroundColor = _isOpen ? widget.pressedForegroundColor : widget.mainForegroundColor;
        }
      });
    }
  }

}

class _ChildrenOverlay extends StatefulWidget {

  final DiamondDialFab widget;
  final GlobalKey<State<StatefulWidget>> dialKey;
  final LayerLink layerLink;
  final AnimationController animationController;
  final Function toggleChildren;

  const _ChildrenOverlay({
    Key? key,
    required this.widget,
    required this.layerLink,
    required this.dialKey,
    required this.animationController,
    required this.toggleChildren,
  }) : super(key: key);

  @override
  State<_ChildrenOverlay> createState() => _ChildrenOverlayState();
}

class _ChildrenOverlayState extends State<_ChildrenOverlay> {
  List<Widget> _getChildrenList() {
    return widget.widget.children
        .map((DiamondDialChild child) {
      int index = widget.widget.children.indexOf(child);

      var childAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: Interval(
            index / widget.widget.children.length,
            1.0,
            curve: Curves.ease,
          ),
        ),
      );

      return AnimatedChild(
        animation: childAnimation,
        index: index,
        btnKey: child.key,
        labelLocation: widget.widget.childLabelLocation,
        backgroundColor: child.backgroundColor,
        foregroundColor: child.foregroundColor,
        buttonSize: widget.widget.childrenButtonSize,
        child: child.child,
        label: child.label,
        labelStyle: child.labelStyle,
        labelBackgroundColor: child.labelBackgroundColor,
        labelWidget: child.labelWidget,
        labelShadow: child.labelShadow,
        onTap: child.onTap,
        toggleChildren: () {
          widget.toggleChildren();
        },
        shapeBorder: child.shapeBorder,
        heroTag: widget.widget.heroTag != null
            ? '${widget.widget.heroTag}-child-$index'
            : null,
      );
    })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Positioned(
            child: CompositedTransformFollower(
              followerAnchor: Alignment.center,
              offset: Offset(widget.dialKey.globalPaintBounds!.width / 2, -
                widget.dialKey.globalPaintBounds!.height -
                  max(widget.widget.childrenButtonSize.height - 56, 0) / 2),
              link: widget.layerLink,
              showWhenUnlinked: false,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: max(widget.widget.buttonSize - 56, 0) / 2,
                  ),
                  child: _buildChildrenColumn(
                    crossAxisAlignment: widget.widget.childLabelLocation == LabelLocation.left
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: _getChildrenList(),
                  ),
                ),
              ),
            )),
      ],
    );
  }

}

Widget _buildChildrenColumn(
    {CrossAxisAlignment? crossAxisAlignment,
      MainAxisAlignment? mainAxisAlignment,
      required List<Widget> children,
      MainAxisSize? mainAxisSize}) {
  return Column(
    mainAxisSize: mainAxisSize ?? MainAxisSize.max,
    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
    crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
    children: children,
  );
}

enum LabelLocation { left, right }
enum DimOverlay { dark, light, none }