import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

import '../pages/camera_page.dart';
import '../pages/upload_page.dart';

class OnCameraPage extends GivenWithWorld<FlutterWorld> {
  OnCameraPage()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    var driver = world.driver!;
    CameraPage page = CameraPage(driver);
    expect(
        await FlutterDriverUtils.isPresent(world.driver, page.getPage()), true);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the camera page");
}

class PressButton extends When1WithWorld<String, FlutterWorld> {
  PressButton()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String button) async {
    await world.driver!.tap(driver.find.byValueKey(button));
  }

  @override
  RegExp get pattern => RegExp(r"I press the {string} button");
}

class UploadImageScreen extends ThenWithWorld<FlutterWorld> {
  UploadImageScreen()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    expect(
        await FlutterDriverUtils.isPresent(
            world.driver, driver.find.byValueKey("UploadPage")),
        true);
  }

  @override
  RegExp get pattern =>
      RegExp(r"the screen for uploading images should pop up");
}

class OnUploadPage extends GivenWithWorld<FlutterWorld> {
  OnUploadPage()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    await world.driver!.tap(driver.find.byValueKey("UploadImage"));
  }

  @override
  RegExp get pattern => RegExp(r"I am on the upload page");
}

class EnterText extends When2WithWorld<String, String, FlutterWorld> {
  EnterText()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String component, String value) async {
    UploadPage page = UploadPage(world.driver!);
    await page.enterText(component, value);
  }

  @override
  RegExp get pattern => RegExp(r"I enter {string} into the {string} field");
}

class CheckText extends Then2WithWorld<String, String, FlutterWorld> {
  CheckText()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(
    String input,
    String value,
  ) async {
    UploadPage page = UploadPage(world.driver!);
    expect(await page.textIsPresent(input, value), true);
  }

  @override
  RegExp get pattern => RegExp(r"the {string} field should contain {string}");
}
