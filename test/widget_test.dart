import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() async {
  await getDataUser();
}

Future getDataUser() async {
  Uri url = Uri.parse("https://reqres.in/api/users/1");
  var response = await http.get(url);
  debugPrint(response.statusCode.toString());
}
