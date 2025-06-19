import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();
      // Select the first camera.
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      // Initialize the controller.
      _initializeControllerFuture = _controller.initialize();
      // If the initialization is successful, call setState to rebuild the widget.
      setState(() {});
    } catch (e) {
      // Handle any errors during initialization.
      print('Error initializing camera: $e');
      // Optionally show an error message to the user.
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the camera preview.
          return Column(
            children: [
              CameraPreview(_controller),
              ElevatedButton(
                onPressed: () async {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  // Handle the captured image (e.g., save or display).
                  Navigator.pop(context, image.path); // Return to previous screen with the image path
                },
                child: Icon(Icons.camera),
              ),
            ],
          );
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
