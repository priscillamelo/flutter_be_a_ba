import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/rendering.dart';
import 'package:flutter_be_a_ba/components/widget_to_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_be_a_ba/components/dashed_letter_component.dart';
import 'package:flutter_be_a_ba/components/drawing_letter_user.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final Image imageBackground = Image.asset('assets/images/quadro_drawing.png');
  final GlobalKey _paintKey = GlobalKey();

  List<Offset> pointsUser = [];
  ui.Image? letterImage;

  late GlobalKey globalKeyTrace;
  late GlobalKey globalKeyUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureImageLetterTrace();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desenhe a Letra'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => pointsUser.clear()),
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              Uint8List imageTrace = await _captureImageLetterTrace();
              Uint8List imageUser = await _captureImageLetterUser();
              setState(() {
                _compareImages(imageTrace, imageUser);
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(children: [
          // Criação de Imagem a partir do widget CustomPaint da letra tracejada
          WidgetToImage(onImageBuilder: (key) {
            globalKeyTrace = key;
            return Center(
              child: CustomPaint(
                key: _paintKey,
                size: const Size(400, 400), // Tamanho fixo do CustomPaint
                painter: DashedLetterComponent(letter: "A"),
              ),
            );
          }),
          Center(
            child: imageBackground,
          ),

          // Criação de Imagem a partir do widget CustomPaint do desenho do usuário
          WidgetToImage(onImageBuilder: (key) {
            globalKeyUser = key;
            return GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final RenderBox renderBox =
                      _paintKey.currentContext!.findRenderObject() as RenderBox;

                  // Convertendo o toque global para local
                  final Offset localOffset =
                      renderBox.globalToLocal(details.globalPosition);

                  pointsUser.add(localOffset);
                });
              },
              onPanEnd: (details) {
                pointsUser.add(
                    Offset.zero); // Adiciona ponto zero para segmentar linhas
              },
              child: Center(
                child: CustomPaint(
                  size: const Size(400, 400), // Mesmo tamanho do CustomPaint
                  painter: DrawingLetterUser(
                    points: pointsUser,
                    color: Colors.blue,
                    strokeWidth: 10.0,
                  ),
                ),
              ),
            );
          })
        ]);
      }),
    );
  }

  Future<Uint8List> _captureImageLetterTrace() async {
    RenderRepaintBoundary? boundary = globalKeyTrace.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes!;
  }

  Future<Uint8List> _captureImageLetterUser() async {
    RenderRepaintBoundary? boundary = globalKeyUser.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes!;
  }

  void _compareImages(Uint8List imageTrace, Uint8List imageUser) async {
    img.Image? imgTrace = img.decodeImage(imageTrace);
    img.Image? imgUser = img.decodeImage(imageUser);

    if (imgTrace == null || imgUser == null) {
      debugPrint('Erro: Falha ao decodificar uma ou ambas as imagens.');
      return;
    }

    // Calcula os pixels cobertos
    int totalPixelsLetterDashed = 0;
    int totalPixelsLetterUser = 0;
    int coveredPixels = 0;

    for (int y = 0; y < imgUser.height; y++) {
      for (int x = 0; x < imgUser.width; x++) {
        img.Pixel pixelTrace = imgTrace.getPixelSafe(x, y);
        img.Pixel pixelUser = imgUser.getPixelSafe(x, y);

        if (pixelUser.b > 0) {
          totalPixelsLetterUser++;
          //coveredPixels++;
        }

        // Verifica se o pixel faz parte da letra (cor vermelha, por exemplo)
        if (pixelTrace.r > 0) {
          totalPixelsLetterDashed++;

          // Verifica se o pixel foi coberto (cor do usuário não é transparente)
          if (pixelUser.a > 0) {
            // totalPixels2++;
            coveredPixels++;
          }
        }
      }
    }

    // Calcula a porcentagem de cobertura
    final newCoveragePercentage =
        (coveredPixels / totalPixelsLetterDashed) * 100;
    bool winner = true;
    if (newCoveragePercentage > 40) {
      _showDialogImage(winner);
    } else {
      _showDialogImage(!winner);
    }
    debugPrint('Total Pixels da letra tracejada: $totalPixelsLetterDashed');
    debugPrint('Total Pixels da letra do usuário: $totalPixelsLetterUser');
    debugPrint('Pixels cobertos: $coveredPixels');
    debugPrint('Percentual: $newCoveragePercentage');
  }

  Future<void> _showDialogImage(bool winner) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner
                ? 'Parabéns! Você conseguiu!!'
                : 'Hummm... Vamos tentar novamente!'),
            content: Image.asset(winner
                ? 'assets/images/winner.png'
                : 'assets/images/loser.png'),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  setState(() {
                    pointsUser.clear();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
