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

/* class VoiceTester extends StatefulWidget {
  @override
  _VoiceTesterState createState() => _VoiceTesterState();
}

class _VoiceTesterState extends State<VoiceTester> {
  final FlutterTts flutterTts = FlutterTts();
  List<dynamic> voices = [];

  @override
  void initState() {
    super.initState();
    _loadVoices();
  }

  Future<void> _loadVoices() async {
    try {
      voices = await flutterTts.getVoices;
      voices = voices.where((voice) => voice["locale"] == "pt-BR").toList();
      setState(() {}); // Atualiza a interface com as vozes carregadas
    } catch (e) {
      print("Erro ao carregar vozes: $e");
    }
  }

  Future<void> _speak(String text, Map<dynamic, dynamic> voice) async {
    try {
      // Converte o mapa para Map<String, String>
      Map<String, String> formattedVoice = {
        "name": voice["name"] as String,
        "locale": voice["locale"] as String,
      };
      // Define a voz e fala o texto
      await flutterTts.setPitch(1.5); // Aumenta o tom, soando mais infantil
      await flutterTts.setSpeechRate(0.5); // Fala mais devagar
      await flutterTts.setVoice(formattedVoice);
      await flutterTts.speak(text);
    } catch (e) {
      print("Erro ao falar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Testador de Vozes")),
      body: voices.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: voices.length,
              itemBuilder: (context, index) {
                final voice = voices[index];
                return ListTile(
                  title: Text(voice["name"] ?? "Voz desconhecida"),
                  subtitle: Text(voice["locale"] ?? "Sem localidade"),
                  onTap: () => _speak("Olá, DESENHE A LETRA 'A'", voice),
                );
              },
            ),
    );
  }
}

void main() => runApp(MaterialApp(home: VoiceTester())); */
