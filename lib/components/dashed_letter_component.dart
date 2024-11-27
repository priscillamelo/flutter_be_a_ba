import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_be_a_ba/models/letters.dart';

class DashedLetterComponent extends CustomPainter {
  final String letter;

  DashedLetterComponent({required this.letter});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 4;
    final double centerY = size.height / 2;

    // Centralize o conteúdo no centro do canvas
    canvas.translate(centerX, centerY);

    // Obtenha o caminho da letra do mapa de paths
    final Path? letterPath = LetterPaths.letterPaths[letter];

    if (letterPath != null) {
      // Desenhar a letra tracejada
      Path dashedPath = _createDashedPath(letterPath, 5.0, 5.0);
      canvas.drawPath(dashedPath, paint);
    }
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path dashedPath = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double nextDistance = distance + dashWidth;
        dashedPath.addPath(
          pathMetric.extractPath(distance, nextDistance),
          Offset.zero,
        );
        distance = nextDistance + dashSpace;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
