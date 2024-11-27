import 'package:flutter/material.dart';
import 'package:flutter_be_a_ba/screens/drawing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desenho de Letras',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const DrawingScreen(),
    );
  }
}
