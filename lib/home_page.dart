import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:new_camera_picker/camera_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
  }

  void _onCapture() async {
    XFile file = await _controller.takePicture();
    String namaFile = file.path.split("/").last;
    File fotoFile = File(file.path);
    log(namaFile);
    //EZPZ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Camera Picker")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    double w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: w * .8,
          height: w * .8,
          child: Stack(
            children: [
              Positioned.fill(
                child: CameraWidget(
                  hasMounted: (CameraController controller) {
                    _controller = controller;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: w * .4,
                  height: w * .4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        IconButton(
          onPressed: _onCapture,
          icon: const Icon(Icons.camera_alt_sharp),
        ),
      ],
    );
  }
}
