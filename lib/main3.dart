import 'package:flutter/material.dart';
import 'screens/tabs_screen.dart'; // asegúrate de que el import sea correcto
import 'dart:convert';


void main() {
  // Simulación de una respuesta JSON del servidor
  const simulatedResponse = '''
  {
    "contexto": ["educación", 123, null, "salud"],
    "proposito": ["investigación", {"otro": "valor"}, "análisis"]
  }
  ''';

  final data = jsonDecode(simulatedResponse) as Map<String, dynamic>;

  final resultado = {
    'contexto': (data.containsKey('contexto') && data['contexto'] is List)
        ? List<String>.from((data['contexto'] as List).whereType<String>())
        : [],
    'proposito': (data.containsKey('proposito') && data['proposito'] is List)
        ? List<String>.from((data['proposito'] as List).whereType<String>())
        : [],
  };

  print('Resultado: $resultado');
}


class EntrixApp extends StatelessWidget {
  const EntrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entrix Sheets',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: EntrixTabsScreen(),
    );
  }
}
