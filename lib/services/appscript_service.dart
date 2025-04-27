import 'dart:convert'; // Asegúrate de tener esta importación
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Importar para debugPrint y kDebugMode

// ✅ URL final confirmada como funcional
const String baseUrl = 'https://script.google.com/macros/s/AKfycbw91vd-tqIxM5c2hUu5EhARibTTzJDYqS6jpi_KjfpPzBLyzRsxg6EnLhbjjrZ-EiM/exec';

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
      // Los debugPrint solo se ejecutarán en modo depuración
      if (kDebugMode) {
        debugPrint('Error sending prompt: Status ${response.statusCode}, Body: ${response.body}');
      }
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    // Los debugPrint solo se ejecutarán en modo depuración
    if (kDebugMode) {
      debugPrint('Exception sending prompt: $e');
    }
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
      // Asegurarse de que las claves existen y son del tipo correcto antes de convertir a List<String>
      return {
        'contexto': (data != null && data is Map && data.containsKey('contexto') && data['contexto'] is List)
            ? List<String>.from(data['contexto']) : [],
        'proposito': (data != null && data is Map && data.containsKey('proposito') && data['proposito'] is List)
            ? List<String>.from(data['proposito']) : [],
      };
    } else {
      // Los debugPrint solo se ejecutarán en modo depuración
      if (kDebugMode) {
        debugPrint('Error getting unique options: Status ${response.statusCode}, Body: ${response.body}');
      }
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  } catch (e) {
    // Los debugPrint solo se ejecutarán en modo depuración
    if (kDebugMode) {
      debugPrint('Exception getting unique options: $e');
    }
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
      // Asegurarse de que la clave existe y es un mapa
      final Map<String, dynamic> rawMap = (data != null && data is Map && data.containsKey('propositoPorContexto') && data['propositoPorContexto'] is Map)
          ? data['propositoPorContexto'] : {}; // Retorna un mapa vacío si no es válido

      Map<String, List<String>> mapa = {};
      rawMap.forEach((key, value) {
        // Asegurarse de que el valor asociado a la clave es una lista antes de convertir
        if (value is List) {
          mapa[key] = List<String>.from(value);
        } else {
          mapa[key] = []; // Retorna lista vacía si el valor no es una lista
        }
      });

      return mapa;
    } else {
      // Los debugPrint solo se ejecutarán en modo depuración
      if (kDebugMode) {
        debugPrint('Error getting grouped options: Status ${response.statusCode}, Body: ${response.body}');
      }
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  } catch (e) {
    // Los debugPrint solo se ejecutarán en modo depuración
    if (kDebugMode) {
      debugPrint('Exception getting grouped options: $e');
    }
    throw Exception('Error al obtener opciones: $e');
  }
}

Future<List<Map<String, dynamic>>> consultarPromptsPorContextoYProposito(
    String contexto, String proposito) async {
  final uri = Uri.parse(
      '$baseUrl?action=queryPrompts&contextoUso=$contexto&propositoUso=$proposito');

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      // Asegurarse de que la respuesta decodificada es una lista antes de mapear
      if (jsonData is List) {
        return jsonData.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        // Los debugPrint solo se ejecutarán en modo depuración
        if (kDebugMode) {
          debugPrint('Query Prompts: Response body is not a List. Body: ${response.body}');
        }
        return []; // Retorna lista vacía si no es una lista
      }
    } else {
      // Los debugPrint solo se ejecutarán en modo depuración
      if (kDebugMode) {
        debugPrint('Error consulting prompts: Status ${response.statusCode}, Body: ${response.body}');
      }
      throw Exception('Error al consultar prompts');
    }
  } catch (e) {
    // Los debugPrint solo se ejecutarán en modo depuración
    if (kDebugMode) {
      debugPrint('Exception consulting prompts: $e');
    }
    throw Exception('Error al consultar prompts: $e');
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

  // Los debugPrint solo se ejecutarán en modo depuración
  if (kDebugMode) {
    debugPrint('--- Appscript Response Debug ---');
    debugPrint('Response Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');
    debugPrint('--- End Appscript Response Debug ---');
  }

  // Analizamos la respuesta JSON del backend para determinar el éxito y ver los mensajes/logs
  if (response.statusCode == 200) {
    try {
      // Intentamos decodificar la respuesta JSON
      final responseData = jsonDecode(response.body);

      // Verificamos la clave 'success' que esperamos del script de Appscript
      // Añadimos verificaciones robustas para evitar errores si la respuesta no es un mapa o no tiene la clave
      if (responseData != null && responseData is Map && responseData.containsKey('success') && responseData['success'] == true) {
        // Los debugPrint solo se ejecutarán en modo depuración
        if (kDebugMode) {
          debugPrint('Backend reported success = true.');
          // Opcional: si el script incluyó un mensaje en la respuesta
          if(responseData.containsKey('message') && responseData['message'] != null) {
            debugPrint('Backend message: ${responseData['message']}');
          }
          // Opcional: si el script incluyó los logs en la respuesta, imprímelos
          if(responseData.containsKey('logs') && responseData['logs'] != null) {
            debugPrint('Backend logs: ${responseData['logs']}');
          }
        }
        return true; // Indica éxito basado en la respuesta JSON del backend
      } else {
        // Los debugPrint solo se ejecutarán en modo depuración
        if (kDebugMode) {
          // Si la respuesta JSON no tiene success: true, o falta la clave
          debugPrint('Backend did not report success = true.');
          if(responseData != null && responseData is Map && responseData.containsKey('message') && responseData['message'] != null) {
            debugPrint('Backend error message: ${responseData['message']}');
          }
          if(responseData != null && responseData is Map && responseData.containsKey('logs') && responseData['logs'] != null) {
            debugPrint('Backend logs: ${responseData['logs']}');
          } else {
            // Si la respuesta no tiene ni success=true ni un mensaje/logs claro, mostramos el cuerpo crudo
            debugPrint('Backend response structure unexpected. Raw body: ${response.body}');
          }
        }
        return false; // Indica fallo basado en la respuesta JSON del backend
      }
    } catch (e) {
      // Los debugPrint solo se ejecutarán en modo depuración
      if (kDebugMode) {
        // Si hubo un error al decodificar el JSON (por ejemplo, si la respuesta no es JSON)
        debugPrint('Error parsing backend response JSON: $e');
        debugPrint('Raw response body was: ${response.body}'); // Vuelve a imprimir el cuerpo crudo por si acaso
      }
      // Considera mostrar un error genérico al usuario si ocurre esto (respuesta inesperada del servidor)
      return false; // Fallo al procesar la respuesta del backend
    }
  } else {
    // Los debugPrint solo se ejecutarán en modo depuración
    if (kDebugMode) {
      // Si el código de estado HTTP no fue 200 (ej: 404, 500, etc.)
      debugPrint('HTTP Error Status Code: ${response.statusCode}');
      // Imprimir el cuerpo de la respuesta aunque no sea 200, por si contiene detalles del error
      debugPrint('Raw response body: ${response.body}');
    }
    // Considera mostrar un error de conexión o servidor al usuario
    return false; // Indica fallo basado en el código de estado HTTP
  }
}

/// ✅ NUEVO: Eliminar un prompt por ID
Future<bool> eliminarPrompt({required String id}) async {
  // Implementación similar a actualizarPrompt, pero para eliminar
  // Es buena práctica también analizar la respuesta JSON del backend para confirmar el éxito.
  final response = await http.post(Uri.parse(baseUrl), body: {
    'action': 'deletePrompt',
    // CAMBIO AQUI: Cambiar 'idPrompt' a 'id' para coincidir con el script de Apps Script
    'id': id, // <--- **CAMBIO IMPORTANTE** (Este cambio ya estaba, lo mantengo)
  });

  // Los debugPrint solo se ejecutarán en modo depuración
  if (kDebugMode) {
    debugPrint('--- Appscript Delete Response Debug ---');
    debugPrint('Response Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');
    debugPrint('--- End Appscript Delete Response Debug ---');
  }

  if (response.statusCode == 200) {
    try {
      final responseData = jsonDecode(response.body);
      if (responseData != null && responseData is Map && responseData.containsKey('success') && responseData['success'] == true) {
        // Los debugPrint solo se ejecutarán en modo depuración
        if (kDebugMode) {
          debugPrint('Backend reported delete success = true.');
          if(responseData.containsKey('message') && responseData['message'] != null) {
            debugPrint('Backend message: ${responseData['message']}');
          }
        }
        return true;
      } else {
        // Los debugPrint solo se ejecutarán en modo depuración
        if (kDebugMode) {
          debugPrint('Backend reported delete success = false.');
          if(responseData != null && responseData is Map && responseData.containsKey('message') && responseData['message'] != null) {
            debugPrint('Backend error message: ${responseData['message']}');
          }
          if(responseData != null && responseData is Map && responseData.containsKey('logs') && responseData['logs'] != null) {
            debugPrint('Backend logs: ${responseData['logs']}');
          } else {
            debugPrint('Backend delete response structure unexpected. Raw body: ${response.body}');
          }
        }
        return false;
      }
    } catch (e) {
      // Los debugPrint solo se ejecutarán en modo depuración
      if (kDebugMode) {
        debugPrint('Error parsing backend delete response JSON: $e');
        debugPrint('Raw response body was: ${response.body}');
      }
      return false;
    }
  } else {
    // Los debugPrint solo se ejecutarán en modo depuración
    if (kDebugMode) {
      debugPrint('HTTP Error Delete Status Code: ${response.statusCode}');
      debugPrint('Raw response body: ${response.body}');
    }
    return false;
  }
}