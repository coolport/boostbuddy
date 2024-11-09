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
    'X-Api-Key': 'generate niyo api key niyo'
  };

  final urlQuotesResponse = await http.get(urlQuotes, headers: headers );
  if (urlQuotesResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  // final json = jsonDecode(httpPackageResponse.body);
  // final package = Package(json['name'], json['latestVersion'], json['description']);
  // print(package);

  final json = jsonDecode(urlQuotesResponse.body);
  // final quote = Quote(json['quote'], json['author']);
  print(json);
  // print(quote);

}