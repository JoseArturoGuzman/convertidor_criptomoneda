import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  final String apiKey;

  ExchangeRateService(this.apiKey);

  /// Obtiene el tipo de cambio entre dos activos.
  /// Retorna el valor del tipo de cambio como `double?`, o `null` en caso de error.
  Future<double?> fetchExchangeRate(String baseAsset, String quoteAsset) async {
    final url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$baseAsset/$quoteAsset');
    final headers = {
      'Accept': 'application/json',
      'X-CoinAPI-Key': apiKey,
    };

    try {
      // Realiza la solicitud a la API
      final response = await http.get(url, headers: headers);

      // Maneja una respuesta exitosa
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Verifica si la clave 'rate' está presente
        if (data.containsKey('rate')) {
          return data['rate'] as double;
        } else {
          print('Error: La clave "rate" no está presente en la respuesta.');
          return null;
        }
      } else {
        // Manejo de errores de la API
        print('Error: Falló la solicitud. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        return null;
      }
    } catch (e) {
      // Manejo de excepciones en caso de errores de red
      print('Error al obtener el tipo de cambio: $e');
      return null;
    }
  }
}
