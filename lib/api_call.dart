import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quote_model.dart';

const url = "https://type.fit/api/quotes";

List<Quote> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Quote>((json) =>Quote.fromJson(json)).toList();
}

Future<List<Quote>> getQuotes() async {
  final response =
  await http.get(url, headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}


Future<Quote> getQuote() async {
  String url = 'https://quotes.rest/qod.json';
  final response =
  await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}


