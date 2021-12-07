import 'package:camera/camera.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  final Function(CameraController controller) hasMounted;

  const CameraWidget({Key? key, required this.hasMounted}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late bool _mounted;

  @override
  void initState() {
    super.initState();
    _mounted = false;
    _initCamera();
  }

  void _initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller.initialize().whenComplete(() {
      setState(() {
        _mounted = true;
        _controller.setFlashMode(FlashMode.off);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_mounted) {
      return Container();
    }
    var tmp = MediaQuery.of(context).size;

    final screenH = math.max(tmp.height, tmp.width);
    final screenW = math.min(tmp.height, tmp.width);

    tmp = _controller.value.previewSize!;

    final previewH = math.max(tmp.height, tmp.width);
    final previewW = math.min(tmp.height, tmp.width);
    final screenRatio = screenH / screenW;
    final previewRatio = previewH / previewW;
    widget.hasMounted(_controller);

    return ClipRRect(
      child: OverflowBox(
        maxHeight: screenRatio > previewRatio
            ? screenH
            : screenW / previewW * previewH,
        maxWidth: screenRatio > previewRatio
            ? screenH / previewH * previewW
            : screenW,
        child: CameraPreview(_controller),
      ),
    );
  }
}
