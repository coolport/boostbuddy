import 'dart:convert';
import 'package:http/http.dart' as http;

class QuotesFetch {
  static Future<Map<String, String>> fetchQuote(String category) async {
    final urlQuotes = Uri.parse('https://api.api-ninjas.com/v1/quotes?category=$category');
    var headers = {
      'X-Api-Key': '22Sw/FqKs4++B+lC243/VQ==xiOpF8RKMO5PxxLI'
    };

    final urlQuotesResponse = await http.get(urlQuotes, headers: headers);

    if (urlQuotesResponse.statusCode == 200) {
      final json = jsonDecode(urlQuotesResponse.body);
      final quoteData = json.isNotEmpty ? json[0] : null;

      if (quoteData != null) {
        return {
          'quote': quoteData['quote'],
          'author': quoteData['author'],
        };
      } else {
        return {
          'quote': 'No quotes found.',
          'author': '',
        };
      }
    } else {
      return {
        'quote': 'Failed to load quote.',
        'author': '',
      };
    }
  }
}
