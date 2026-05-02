import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/core.dart';

class HistoryService {
  final base = ApiConstants.baseUrl;
  final historyEndpoint = ApiConstants.historyEndpoint;

  Future<Map<String, dynamic>> getAnalytics(String date) async {
    final res = await http.get(
      Uri.parse("$base/$historyEndpoint/analytics?date=$date"),
    );

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.body}");
    }

    return jsonDecode(res.body);
  }

}