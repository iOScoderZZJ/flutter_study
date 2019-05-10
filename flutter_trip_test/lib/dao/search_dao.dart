import 'package:flutter_trip_test/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchDao {
  static Future<SearchModel> fetch(String url,String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromjson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}