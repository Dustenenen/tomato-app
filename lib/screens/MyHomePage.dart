// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

late List<CameraDescription> cameras;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _controller;

  // For picker
  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: const Color(0xFF53624F),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPicker(context: context);
        },
        backgroundColor: const Color(0xFF00281C),
        shape: const CircleBorder(),
        // ignore: prefer_const_constructors
        child: Icon(
          Icons.file_upload_rounded,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.center, // Align the children to the center
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height / 10,
                  left: MediaQuery.of(context).size.width / 2 -
                      MediaQuery.of(context).size.width * 0.45,
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.9, // 80% of the screen width
                    height: MediaQuery.of(context).size.height *
                        0.6, // 50% of the screen height
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10)),
                    child: CameraPreview(_controller),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
