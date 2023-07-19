import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class CoursesApi{

  getCourses() async {
    var url =
      Uri.https('http://mermez.xyz/flutter-api');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var data = jsonResponse['totalItems'];
    print('Number of books about http: $data.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  }
}