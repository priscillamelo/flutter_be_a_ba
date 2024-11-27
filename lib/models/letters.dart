import 'package:flutter/material.dart';

class LetterPaths {
  static Map<String, Path> letterPaths = {
    'A': Path()
      ..moveTo(50, 150)
      ..lineTo(100, 50)
      ..lineTo(150, 150)
      ..moveTo(75, 100)
      ..lineTo(125, 100),
    'B': Path()
      ..moveTo(50, 50)
      ..lineTo(50, 150)
      ..moveTo(50, 50)
      ..lineTo(100, 50)
      ..moveTo(100, 50)
      ..lineTo(100, 100)
      ..moveTo(100, 100)
      ..lineTo(50, 100)
      ..moveTo(50, 100)
      ..lineTo(100, 150)
      ..moveTo(100, 150)
      ..lineTo(50, 150),
    // Adicione outras letras aqui
  };
}
