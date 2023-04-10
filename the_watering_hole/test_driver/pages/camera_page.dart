import 'package:flutter_driver/flutter_driver.dart';

class CameraPage {
  final cameraPreview = find.byValueKey('CameraPreview');
  final cameraButton = find.byValueKey('CameraButton');

  final FlutterDriver _driver;

  CameraPage(this._driver);

  // Get the title of the page
  SerializableFinder getPage() {
    return find.byValueKey("CameraPage");
  }

  // Get the camera preview
  SerializableFinder getCameraPreview() {
    return cameraPreview;
  }

  // Take a photo using the camera button
  Future<void> takePhoto() async {
    return await _driver.tap(cameraButton);
  }
}
