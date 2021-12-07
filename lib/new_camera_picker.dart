import 'package:flutter/material.dart';
import 'package:new_camera_picker/home_page.dart';

class NewCameraPicker extends StatelessWidget {
  const NewCameraPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "New Camera Picker",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}