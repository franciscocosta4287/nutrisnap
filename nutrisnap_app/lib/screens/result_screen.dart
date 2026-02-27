import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/analysis_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final analysis =
        Provider.of<AnalysisProvider>(context).analysis;

    return Scaffold(
      appBar: AppBar(title: const Text("Resultado")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: analysis == null
            ? const Center(child: Text("Sem dados"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${analysis.calories ?? 0} kcal",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _macroTile("Proteína", analysis.protein),
                  _macroTile("Carboidratos", analysis.carbs),
                  _macroTile("Gorduras", analysis.fats),
                ],
              ),
      ),
    );
  }

  Widget _macroTile(String label, double? value) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text("${value ?? 0} g"),
      ),
    );
  }
}