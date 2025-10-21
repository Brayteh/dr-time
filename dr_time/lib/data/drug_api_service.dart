import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dr_time/domain/drug_info.dart'; // Import DrugInfo

class DrugApiService {
  final String _baseUrl = 'https://api.fda.gov/drug/label.json';

  Future<List<DrugInfo>> searchDrugs(String query, {int limit = 15}) async {
    if (query.trim().isEmpty) { // Trim query to handle whitespace only input
      return [];
    }

    // Suche nach Marken- oder generischem Namen
    final searchUrl = '$_baseUrl?search=(openfda.brand_name:"$query" OR openfda.generic_name:"$query")&limit=$limit';
    
    try {
      final response = await http.get(Uri.parse(searchUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List?; // Make it nullable
        if (results == null || results.isEmpty) {
          return []; // No results found in the API response
        }
        return results.map((json) => DrugInfo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load drugs: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Rethrow the exception to be caught by the UI layer
      throw Exception('Network error or invalid response: $e');
    }
  }
}