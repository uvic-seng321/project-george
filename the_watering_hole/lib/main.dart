import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_photo_screen.dart';
import 'Feed.dart';
import 'backend.dart';
// screens/camera_screen.dart';

//List<CameraDescription> cameraList = [];

// main has to be an async function to allow the 'await' in the camera detection
// before launching the app
// void main() async {

//global lol
// ignore: prefer_typing_uninitialized_variables
var firstCamera;

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameraList = await availableCameras();
  // Get a specific camera from the list of available cameras.
  firstCamera = cameraList.first;

  // Launch the app
  runApp(const TabBar1());
}

class TabBar1 extends StatelessWidget {
  const TabBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(
                    icon: Icon(Icons.dynamic_feed),
                    key: ValueKey("FeedViewButton")),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TakePhotoScreen(
                camera: firstCamera,
              ),
              const PostList(key: ValueKey("FeedView")),
            ],
          ),
        ),
      ),
    );
  }
}
