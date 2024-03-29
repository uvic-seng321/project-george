import 'dart:io';
import 'backend.dart';
import 'main.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
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
      home: TakePhotoScreen(
        camera: firstCamera,
      ),
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

class TakePhotoScreenState extends State<TakePhotoScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
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
  void dispose() {
    //dispose of controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You must wait until the controller is initialized before displaying the
    // camera preview. Use a FutureBuilder to display a loading spinner until the
    // controller has finished initializing.
    return Stack(
        key: const ValueKey("CameraPage"),
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller,
                    key: const ValueKey("CameraPreview"));
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                key: const ValueKey("UploadImage"),
                // Provide an onPressed callback.
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChoosePictureScreen(
                          // Context needed for building page
                          )));
                },
                child: const Icon(Icons.image),
              ),
              FloatingActionButton(
                key: const ValueKey("TakePicture"),
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
                    if (!mounted) {
                      return;
                    }
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                              imagePath: image.path,
                            )));
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    // Provide an onPressed callback.
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChoosePictureScreen(
                              // Context needed for building page
                              )));
                    },
                    child: const Icon(Icons.image),
                  ),
                  FloatingActionButton(
                    key: const ValueKey("CameraButton"),
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
                        if (!mounted) {
                          return;
                        }
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                                  imagePath: image.path,
                                )));
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                    },

                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ],
          ),
        ]);
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String hintText1 =
      "Tags separated by commas (eg. bird, peacock, george)";
  final String hintText2 = "Latitude";
  final String hintText3 = "Longitude";

  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final tags = TextEditingController();
  var img = null;

  DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Preview: Camera')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.file(File(imagePath)),
          TextField(
            key: const ValueKey("TagInput"),
            controller: tags,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: hintText1,
            ),
          ),
          TextField(
            key: const ValueKey("LatitudeInput"),
            controller: latitude,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: hintText2,
            ),
          ),
          TextField(
            key: const ValueKey("LongitudeInput"),
            controller: longitude,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: hintText3,
            ),
          ),
          FloatingActionButton(
            // Provide an onPressed callback.
            onPressed: () async {
              //send upload to backend
              var tagsList = tags.text.split(',');
              double lat = double.parse(latitude.text);
              double long = double.parse(longitude.text);
              img = File(imagePath);

              if (img != null) {
                var post =
                    Post(id: 1, tags: tagsList, latitude: lat, longitude: long);
                post.imageFile = img;
                uploadPost(post);
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

Future<File?> _getFromGallery() async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    return (imageFile);
  }
  return null;
}

class ChoosePictureScreen extends StatelessWidget {
  ChoosePictureScreen({
    super.key,
  });

  final String hintText1 =
      "Tags separated by commas (eg. bird, peacock, george)";
  final String hintText2 = "Latitude";
  final String hintText3 = "Longitude";

  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final tags = TextEditingController();
  File? img = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Preview: Gallery')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: tags,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: hintText1,
            ),
          ),
          TextField(
            controller: latitude,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: hintText2,
            ),
          ),
          TextField(
            controller: longitude,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: hintText3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                // Provide an onPressed callback.
                onPressed: () async {
                  img = await _getFromGallery();
                },
                child: const Icon(Icons.image),
              ),
              FloatingActionButton(
                // Provide an onPressed callback.
                onPressed: () async {
                  //send upload to backend
                  var tagsList = tags.text.split(',');
                  double lat = double.parse(latitude.text);
                  double long = double.parse(longitude.text);

                  if (img != null) {
                    var post = Post(
                        id: 1, tags: tagsList, latitude: lat, longitude: long);
                    post.imageFile = img;
                    uploadPost(post);
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
