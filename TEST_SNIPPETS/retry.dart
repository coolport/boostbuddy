import 'dart:convert';
import 'package:http/http.dart' as http;


class Package {
  final String name;
  final String latestVersion;
  final String? description;

  Package(this.name, this.latestVersion, this.description);

  @override
  String toString() {
    return 'Package{name: $name, latestVersion: $latestVersion, description: $description}';

  }
}

void main() async{
  final httpPackage = Uri.http('dart.dev', '/f/packages/http.json');
  final httpPackageResponse = await http.get(httpPackage);
  if (httpPackageResponse.statusCode != 200){
    print('Get request failed.');
  }

  final jsonInfo = jsonDecode(httpPackageResponse.body);
  final package = Package(jsonInfo['name'], jsonInfo['latestVersion'], jsonInfo['description']);

  print(package);

} 

// var decode  body of response
// create package object with info to print

