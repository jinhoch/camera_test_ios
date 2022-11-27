import 'package:camera_example/main.dart';
import 'package:flutter/material.dart';
import 'package:manual_camera/camera.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      cameras[1],
      ResolutionPreset.veryHigh,
      iso: 1300,
      shutterSpeed: 1000 ~/ 8,
      focusDistance: 5,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      Future.delayed(
        Duration(
          milliseconds: 1000,
        ),
      ).then((_) => _controller!.flash(false));
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    if (!_controller!.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: CameraPreview(_controller));
  }
}
