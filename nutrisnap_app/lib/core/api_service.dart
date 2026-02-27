import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/analysis_model.dart';
import 'constants.dart';

class ApiService {
  static Future<AnalysisModel> uploadImage(File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${AppConstants.baseUrl}/api/analyze/"),
    );

    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = json.decode(responseData);

    return AnalysisModel.fromJson(jsonData);
  }

  static Future<List<AnalysisModel>> fetchHistory() async {
    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/api/analyze/"),
    );

    final List data = json.decode(response.body);
    return data.map((e) => AnalysisModel.fromJson(e)).toList();
  }

  static Future<AnalysisModel> fetchById(int id) async {
  final response = await http.get(
    Uri.parse("${AppConstants.baseUrl}/api/analyze/"),
  );

  final List data = json.decode(response.body);
  final item = data.firstWhere((e) => e['id'] == id);
  return AnalysisModel.fromJson(item);
    }
}