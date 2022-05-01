import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  //Pass headers below
  http.get(Uri.parse('http://35.160.71.50/api/soil/?soil=45z79kkiish0y0xne0gs'),
      headers: {
        "Authorization": "Token 87d61bd2475d7ee3ddf24cb148e84d8f1557b3f4"
      }).then((http.Response response) {
    final int statusCode = response.statusCode;

    var scores = jsonDecode(response.body);
    print(scores[0]['soilId']);
  });
}
