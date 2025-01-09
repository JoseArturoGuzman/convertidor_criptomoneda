import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchExchangeRate(String baseAsset, String quoteAsset, String apiKey) async {
  final url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$baseAsset/$quoteAsset');
  final headers = {
    'Accept': 'application/json',
    'X-CoinAPI-Key': apiKey,
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Exchange Rate: ${data['rate']}');
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}