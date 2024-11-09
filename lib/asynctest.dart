Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 2), () => 'Data loaded');
}

void main() {
  fetchData().then((data) {
    print(data); // Runs after 2 seconds
  });
  print('Fetching data...'); // Runs immediately
}
