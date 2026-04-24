import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';

class HistoryService {
  Future<List<dynamic>> getHistory() async {
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}${ApiConstants.historyEndpoint}"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load history");
    }
  }
}
