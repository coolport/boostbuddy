import 'dart:convert';
import 'package:http/http.dart' as http;

class Quote {
  final String quote;
  final String author; 

  Quote(this.quote, this.author);

  @override
  String toString() {
    return 'Quote{quote: $quote, author: $author';
  }
}
// 
void main() async {
  // final urlQuotes = Uri.https('api.api-ninjas.com/v1/quotes?category=happiness');
  // const urlQuotes = "https://api.api-ninjas.com/v1/quotes?category=happiness"; 

  final urlQuotes = Uri.parse('https://api.api-ninjas.com/v1/quotes?category=happiness');
  print(urlQuotes);

  var headers = { 
    'X-Api-Key': '22Sw/FqKs4++B+lC243/VQ==xiOpF8RKMO5PxxLI'
  };

  final urlQuotesResponse = await http.get(urlQuotes, headers: headers );
  if (urlQuotesResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  // final json = jsonDecode(httpPackageResponse.body);
  // final package = Package(json['name'], json['latestVersion'], json['description']);
  // print(package);

  // final json = jsonDecode(urlQuotesResponse.body);
  // // final quote = Quote(json['quote'], json['author']);
  // // print(quote);
  // print(json);
  // // print(quote);

final json = jsonDecode(urlQuotesResponse.body);

  // Extract the first quote from the list
  final quoteData = json.isNotEmpty ? json[0] : null;

  if (quoteData != null) {
    final quote = Quote(quoteData['quote'], quoteData['author']);
    print('Quote: ${quote.quote}');
    print('Author: ${quote.author}');
  } else {
    print('No quotes found.');
  }

}