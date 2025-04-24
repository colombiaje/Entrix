import 'package:flutter/material.dart';
import 'screens/crear_prompt_widget.dart';

void main() {
  runApp(const EntrixApp());
}

class EntrixApp extends StatelessWidget {
  const EntrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entrix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: PromptFormScreen(),
    );
  }
//foco 1
}
