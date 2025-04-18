import 'package:flutter/material.dart';
import '../services/appscript_service.dart';

class PromptConsultaWidget extends StatefulWidget {
  const PromptConsultaWidget({super.key});

  @override
  State<PromptConsultaWidget> createState() => _PromptConsultaWidgetState();
}

class _PromptConsultaWidgetState extends State<PromptConsultaWidget> {
  String? contextoSeleccionado;
  String? propositoSeleccionado;

  List<String> contextos = [];
  List<String> propositos = [];
  List<Map<String, dynamic>> promptsEncontrados = [];

  Map<String, List<String>> propositosPorContexto = {};

  bool cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarOpciones();
  }

  Future<void> _cargarOpciones() async {
    try {
      final data = await obtenerOpcionesUnicas();
      final agrupados = await obtenerOpcionesUnicasAgrupadas();

      setState(() {
        contextos = data['contexto']!..sort();
        propositosPorContexto = agrupados;
      });
    } catch (e) {
      debugPrint('Error cargando opciones: $e');
    }
  }

  Future<void> buscarPrompts() async {
    if (contextoSeleccionado == null || propositoSeleccionado == null) return;

    setState(() => cargando = true);

    try {
      final data = await consultarPromptsPorContextoYProposito(
        contextoSeleccionado!,
        propositoSeleccionado!,
      );

      setState(() {
        promptsEncontrados = List<Map<String, dynamic>>.from(data);
        cargando = false;
      });
    } catch (e) {
      setState(() => cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al consultar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40),
        const Text(
          '🔍 Consultar Prompts',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // 🔹 Dropdown: Contexto

        //...

        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Contexto de uso',
            filled: true,
            fillColor: contextoSeleccionado == null || contextoSeleccionado!.isEmpty
                ? Colors.red[100]  // Rojo si está vacío
                : contextoSeleccionado!.length > 2
                ? Colors.green[100]  // Verde si tiene más de dos caracteres
                : Colors.yellow[100], // Amarillo si tiene menos de tres caracteres
          ),
          value: contextoSeleccionado,
          items: contextos.map((ctx) {
            final partes = ctx.trim().split(' ');
            final primera = partes.isNotEmpty ? partes.first : ctx;
            final resto = partes.length > 1 ? ctx.substring(primera.length) : '';

            return DropdownMenuItem(
              value: ctx,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '$primera ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent, // Resaltado
                      ),
                    ),
                    TextSpan(text: resto),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              contextoSeleccionado = value;
              propositoSeleccionado = null;
              propositos = propositosPorContexto[value] ?? [];
              propositos.sort();
              promptsEncontrados = [];
            });
          },
        ),

        //...

        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Propósito de uso',
            filled: true,
            fillColor: propositoSeleccionado == null || propositoSeleccionado!.isEmpty
                ? Colors.red[100]  // Rojo si está vacío
                : propositoSeleccionado!.length > 2
                ? Colors.green[100]  // Verde si tiene más de dos caracteres
                : Colors.yellow[100], // Amarillo si tiene menos de tres caracteres
          ),
          value: propositoSeleccionado,
          items: propositos.map((p) {
            final partes = p.trim().split(' ');
            final primera = partes.isNotEmpty ? partes.first : p;
            final resto = partes.length > 1 ? p.substring(primera.length) : '';

            return DropdownMenuItem(
              value: p,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '$primera ', // Primera palabra resaltada
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent, // Resaltado
                      ),
                    ),
                    TextSpan(text: resto), // Resto del texto
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              propositoSeleccionado = value;
            });
            if (value != null) buscarPrompts();  // Se ejecuta solo si el valor no es nulo
          },
        ),

        //..
        const SizedBox(height: 16),

        // 🔹 Botón de búsqueda
        ElevatedButton(
          onPressed: buscarPrompts,
          child: const Text('Buscar Prompts'),
        ),

        const SizedBox(height: 20),

        // 🔹 Resultados
        if (cargando)
          const Center(child: CircularProgressIndicator())
        else if (promptsEncontrados.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: promptsEncontrados.map((fila) {
              final promptTexto = fila['prompt'];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(promptTexto),
                ),
              );
            }).toList(),
          )
        else if (contextoSeleccionado != null && propositoSeleccionado != null)
            const Text('No se encontraron prompts con esos filtros.'),
      ],
    );
  }
}
