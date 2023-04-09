import 'package:flutter_driver/flutter_driver.dart';

class CameraPage {
  final cameraPreview = find.byValueKey('CameraPreview');
  final cameraButton = find.byValueKey('CameraButton');
  // final btnIncrement = find.byTooltip('Increment');
  // final btnAdd = find.byValueKey("add");
  // final btnSubtract = find.byValueKey("subtract");
  // final txtAlert = find.byValueKey("alert_text");
  // final btnClose = find.byValueKey("close_button");

  final FlutterDriver _driver;

  //Constructor
  CameraPage(this._driver);

  Future<String> getPageTitle() async {
    return await _driver.getText(find.byValueKey("CameraPageText"));
  }

  SerializableFinder getCameraPreview() {
    return cameraPreview;
  }

  Future<void> takePhoto() async {
    return await _driver.tap(cameraButton);
  }

  // Future<String> getCounterValue() async {
  //   return await _driver.getText(txtCounter);
  // }

  // Future<void> clickBtnPlus() async {
  //   return await _driver.tap(btnIncrement);
  // }

  // Future<void> clickSubtractButton() async {
  //   return _driver.tap(btnSubtract);
  // }
}
