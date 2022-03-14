import 'package:flutter/material.dart';

class DiamondBorder extends ShapeBorder {

  const DiamondBorder();

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    int round = 8;
    // TODO: implement getOuterPath
    return Path()
      ..moveTo(rect.left + rect.width / 2.0 - round, rect.top + round) //상
      ..quadraticBezierTo(rect.left + rect.width / 2.0, rect.top, rect.left + rect.width / 2.0 + round,  rect.top + round)
      ..lineTo(rect.right - round, rect.top + rect.height / 2.0 - round) //우
      ..quadraticBezierTo(rect.right,  rect.top + rect.height / 2.0, rect.right - round,  rect.top + rect.height / 2.0 + round)
      ..lineTo(rect.left + rect.width  / 2.0 + round, rect.bottom - round) // 하
      ..quadraticBezierTo(rect.left + rect.width  / 2.0,  rect.bottom, rect.left + rect.width / 2.0 - round, rect.bottom - round)
      ..lineTo(rect.left + round, rect.top + rect.height / 2.0 + round)
      ..quadraticBezierTo(rect.left, rect.top + rect.height / 2.0, rect.left + round, rect.top + rect.height / 2.0 - round)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }
//
// @override
// EdgeInsetsGeometry get dimensions {
//   return const EdgeInsets.only();
// }
//
// @override
// Path getInnerPath(Rect rect, { TextDirection textDirection }) {
//   return getOuterPath(rect, textDirection: textDirection);
// }
//
// @override
// Path getOuterPath(Rect rect, { TextDirection textDirection }) {
//   return
// }
//
}