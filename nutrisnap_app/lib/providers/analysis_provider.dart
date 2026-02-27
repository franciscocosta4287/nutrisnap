import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/analysis_model.dart';

class AnalysisProvider extends ChangeNotifier {
  AnalysisModel? analysis;
  bool isLoading = false;

  Future<void> analyzeImage(File image) async {
    isLoading = true;
    notifyListeners();

    analysis = await ApiService.uploadImage(image);

    await _pollStatus();

    isLoading = false;
    notifyListeners();
  }

  Future<void> _pollStatus() async {
    if (analysis == null) return;

    while (analysis!.status == "processing") {
      await Future.delayed(const Duration(seconds: 2));
      analysis = await ApiService.fetchById(analysis!.id);
      notifyListeners();
    }
  }
}