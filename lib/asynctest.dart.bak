Future<String> fetchData() {
  return Future.delayed(const Duration(seconds: 2), () => 'Data loaded');
}

void main() {
  fetchData().then((data) {
    print(data); // Runs after 2 seconds
  });
  print('Fetching data...'); // Runs immediately
}

//fetchData() returns a Future, .then() is used to handle the result once ready
