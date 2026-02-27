class AnalysisModel {
  final int id;
  final String status;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fats;

  AnalysisModel({
    required this.id,
    required this.status,
    this.calories,
    this.protein,
    this.carbs,
    this.fats,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    return AnalysisModel(
      id: json['id'],
      status: json['status'],
      calories: json['calories']?.toDouble(),
      protein: json['protein']?.toDouble(),
      carbs: json['carbs']?.toDouble(),
      fats: json['fats']?.toDouble(),
    );
  }
}