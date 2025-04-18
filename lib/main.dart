import 'package:flutter/material.dart';
import 'screens/prompt_form.dart';

void main() {
  runApp(const ZtorePromptApp());
}

class ZtorePromptApp extends StatelessWidget {
  const ZtorePromptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZtorePrompt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: PromptFormScreen(),
    );
  }
  //foco 1
}
