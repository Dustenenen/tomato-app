import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

late List<CameraDescription> cameras;
 
class CameraPage extends StatefulWidget {
  const CameraPage({Key? key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  double _zoomLevel = 0.0;
  bool _sliderVisible = true;
  bool _imageCaptured = false; // Track if an image has been captured

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
            if (_sliderVisible)
              Positioned(
                width: MediaQuery.of(context).size.width * 0.95,
                top: MediaQuery.of(context).size.height / 1.68,
                child: Slider(
                  value: _zoomLevel,
                  min: 0.0,
                  max: 3.0,
                  onChanged: (value) {
                    setState(() {
                      _zoomLevel = value;
                      _controller.setZoomLevel(_zoomLevel);
                    });
                  },
                ),
              ),
            GestureDetector(
              onTap: _captureImage,
              child: Stack(
                alignment: Alignment.center,
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
                      child: galleryFile == null
                          ? CameraPreview(_controller
                            ..setZoomLevel(_zoomLevel)
                            ..startImageStream((image) {
                              // Do something with the image stream
                            }))
                          : Image.file(galleryFile!),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 10,
                    MediaQuery.of(context).size.height / 2.25,
                    20,
                    16),
                child: const Text(
                  'Predicted Disease: ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 10,
                    MediaQuery.of(context).size.height / 1.75,
                    20,
                    16),
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
                  onPressed: _imageCaptured ? null : () {
                    // Add your functionality here
                  },
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
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future<void> _captureImage() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    final XFile file = await _controller.takePicture();
    setState(() {
      galleryFile = File(file.path);
      _sliderVisible = false; // Hide the slider after capturing
      _imageCaptured = true; // Image has been captured
    });

    // Save the image to the photo library
    await GallerySaver.saveImage(file.path);
  }
}
