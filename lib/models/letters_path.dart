import 'package:flutter/material.dart';

class LettersPath {
  static Map<String, Path> letterPaths = {
    'A': Path()
      ..moveTo(70, 0)
      ..lineTo(20, 150)
      ..moveTo(70, 0)
      ..lineTo(130, 150)
      ..moveTo(50, 75)
      ..lineTo(100, 75)
    /* ..lineTo(150, 150)
      ..moveTo(75, 100)
      ..lineTo(125, 100) */
    ,
    'B': Path()
      ..moveTo(30, 0)
      ..lineTo(30, 180)
      ..moveTo(30, 0)
      ..arcToPoint(
        Offset(100, 90),
        radius: Radius.circular(20),
        clockwise: true,
      )
      ..moveTo(30, 90)
      ..lineTo(100, 90)
      ..moveTo(100, 90)
      ..arcToPoint(
        Offset(30, 180),
        radius: Radius.circular(20),
        clockwise: true,
      ),

    /* 'C': Path()
      ..moveTo(100, 10)
      ..addArc(Rect.fromLTRB(50, 50, 100, 100), pi / 2, pi *2),
    /* ..arcToPoint(
        Offset(100, 190),
        radius: Radius.circular(80),
        clockwise: false,
      ), */ */

    // Adicione outras letras aqui

    'D': Path()
      ..moveTo(40, 0)
      ..lineTo(40, 200)
      ..moveTo(40, 0)
      ..arcToPoint(
        Offset(40, 200),
        radius: Radius.circular(20),
        clockwise: true,
      ),

    'P': Path()
      ..moveTo(40, 0)
      ..lineTo(40, 200)
      ..moveTo(40, 0)
      ..arcToPoint(
        Offset(100, 100),
        radius: Radius.circular(20),
        clockwise: true,
      )
      ..moveTo(40, 100)
      ..arcToPoint(
        Offset(100, 100),
        radius: Radius.circular(50),
        clockwise: false,
      ),
  };
}
