import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/analysis_provider.dart';
import 'result_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });

      final provider =
          Provider.of<AnalysisProvider>(context, listen: false);

      await provider.analyzeImage(_image!);

      if (provider.analysis?.status == "completed") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const ResultScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnalysisProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tire uma foto")),
      body: Center(
        child: provider.isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitCircle(
                    color: Colors.green,
                    size: 60,
                  ),
                  SizedBox(height: 20),
                  Text("Analisando seu prato..."),
                ],
              )
            : ElevatedButton(
                onPressed: _pickImage,
                child: const Text("Abrir Câmera"),
              ),
      ),
    );
  }
}