import 'package:flutter/material.dart';
import 'package:tomatoapp/screens/CameraPage.dart';
import 'package:tomatoapp/screens/LandingPage.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tomato Leaf Disease Detector App',
      home: LandingPage(),
    );
  }
}
