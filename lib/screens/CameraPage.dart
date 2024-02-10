import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

late List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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
      backgroundColor: const Color(0xFF38384E),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPicker(context: context);
        },
        backgroundColor: const Color.fromARGB(255, 29, 168, 47),
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
                        0.5, // 50% of the screen height
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10)),
                    child: CameraPreview(_controller),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  bottom: 16,
                  top: MediaQuery.of(context).size.height / 2.5,
                ),
                child: const Text(
                  'Predicted Disease: ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  bottom: 16,
                  top: MediaQuery.of(context).size.height / 2,
                ),
                child: const Text(
                  'Confidence Level:',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 29, 168, 47),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                  ),
                  child: const Text('Learn More'),
                ),
              ),
            ),
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
