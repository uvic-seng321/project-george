import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'backend.dart';

Future<void> main() async{
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameraList = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameraList.first;

  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TakePhotoScreen(camera: firstCamera,),
    ),
  );
}


// Camera Integration Page
class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePhotoScreenState createState() => TakePhotoScreenState();
}

class TakePhotoScreenState extends State<TakePhotoScreen>{
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState(){
    super.initState();
    // To display the current output of the camera, we create a camera controller
    _controller = CameraController(
      // Get the camera we want (ex. back camera)
      widget.camera,
      ResolutionPreset.medium,
    );

    //Initialize the controller
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose(){
    //dispose of controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context){
    // You must wait until the controller is initialized before displaying the
    // camera preview. Use a FutureBuilder to display a loading spinner until the
    // controller has finished initializing.
    return Scaffold(
      appBar: AppBar(title: const Text('Take a photo')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
         },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
         // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and then get the location
            // where the image file is saved.
          final image = await _controller.takePicture();
          if (!mounted){
            return;
          }
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> DisplayPictureScreen(
              imagePath: image.path,
                )
              )
          );
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
      child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget{
  final String imagePath;

  const DisplayPictureScreen({
    super.key, required this.imagePath
    }
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Picture Preview')),
      body: Image.file(File(imagePath)),
    );
  }
}
