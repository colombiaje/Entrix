import 'dart:convert';
import 'package:http/http.dart' as http;

// ✅ URL final confirmada como funcional
const String baseUrl = 'https://script.google.com/macros/s/AKfycbxDz7ixsztfFkiDKz2MnByyDUl5d4evVvvorJ_6_m6BA5GuZ3sq1VS2t4Fpi7K5dyvs/exec';

/// 🔹 Enviar un nuevo prompt (acción: 'addPrompt') usando POST
Future<String> enviarPrompt({
  required String contextoUso,
  required String propositoUso,
  required String promptTexto,
}) async {
  final url = Uri.parse(baseUrl);

  try {
    final response = await http.post(
      url,
      body: {
        'action': 'addPrompt',
        'contextoUso': contextoUso,
        'propositoUso': propositoUso,
        'promptTexto': promptTexto,
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    return 'Excepción: $e';
  }
}

/// 🔹 Leer opciones únicas desde Google Sheets (acción: 'getOptions')
Future<Map<String, List<String>>> obtenerOpcionesUnicas() async {
  final url = Uri.parse('$baseUrl?action=getOptions');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'contexto': List<String>.from(data['contexto']),
        'proposito': List<String>.from(data['proposito']),
      };
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al obtener opciones únicas: $e');
  }
}

/// 🔹 Agrupa los propósitos por contexto (de forma eficiente con el JSON)
Future<Map<String, List<String>>> obtenerOpcionesUnicasAgrupadas() async {
  final url = Uri.parse('$baseUrl?action=getOptions');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final Map<String, dynamic> rawMap = data['propositoPorContexto'];

      Map<String, List<String>> mapa = {};
      rawMap.forEach((key, value) {
        mapa[key] = List<String>.from(value);
      });

      return mapa;
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al obtener opciones: $e');
  }
}

Future<List<Map<String, dynamic>>> consultarPromptsPorContextoYProposito(
    String contexto, String proposito) async {
  final uri = Uri.parse(
      '$baseUrl?action=queryPrompts&contextoUso=$contexto&propositoUso=$proposito');

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item)).toList();
  } else {
    throw Exception('Error al consultar prompts');
  }
}

//Agregado por cambio del Script para estas dos funciones.

/// ✅ NUEVO: Actualizar un prompt por ID
Future<bool> actualizarPrompt({
  required String id,
  required String nuevoTexto,
}) async {
  final response = await http.post(Uri.parse(baseUrl), body: {
    'action': 'updatePrompt',
    'idPrompt': id,
    'nuevoTexto': nuevoTexto,
  });

  return response.statusCode == 200;
}

/// ✅ NUEVO: Eliminar un prompt por ID
Future<bool> eliminarPrompt({required String id}) async {
  final response = await http.post(Uri.parse(baseUrl), body: {
    'action': 'deletePrompt',
    'idPrompt': id,
  });

  return response.statusCode == 200;
}


