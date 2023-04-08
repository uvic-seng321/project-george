import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class OnHomePage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {}

  @override
  RegExp get pattern => RegExp(r"I am on the home page");
}

class CheckCameraPreview extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    expect(
        await FlutterDriverUtils.isPresent(
            world.driver, find.byType("CameraPreview")),
        true);
  }

  @override
  RegExp get pattern => RegExp(r"I should see a camera preview");
}
