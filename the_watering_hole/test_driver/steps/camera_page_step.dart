import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

import '../pages/camera_page.dart';

class OnCameraPage extends GivenWithWorld<FlutterWorld> {
  OnCameraPage()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    var driver = world.driver!;
    CameraPage page = CameraPage(driver);
    var title = await page.getPageTitle();
    expectMatch(title, "Take a photo");
  }

  @override
  RegExp get pattern => RegExp(r"I am on the camera page");
}

class LookAtPage extends WhenWithWorld<FlutterWorld> {
  LookAtPage()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {}

  @override
  RegExp get pattern => RegExp(r"I look at the screen");
}

class CheckCameraPreview extends ThenWithWorld<FlutterWorld> {
  CheckCameraPreview()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    expect(
        await FlutterDriverUtils.isPresent(
            world.driver, find.byValueKey("CameraPreview")),
        true);
  }

  @override
  RegExp get pattern => RegExp(r"I should see a camera preview");
}
