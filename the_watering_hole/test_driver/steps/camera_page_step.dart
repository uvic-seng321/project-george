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
    expect(
        await FlutterDriverUtils.isPresent(world.driver, page.getPage()), true);
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

class CheckCameraPreview extends Then1WithWorld<String, FlutterWorld> {
  CheckCameraPreview()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String component) async {
    expect(
        await FlutterDriverUtils.isPresent(
            world.driver, find.byValueKey(component)),
        true);
  }

  @override
  RegExp get pattern => RegExp(r"I should see a {string} component");
}

class ComponentIsShown extends When1WithWorld<String, FlutterWorld> {
  ComponentIsShown()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String component) async {
    expect(
        await FlutterDriverUtils.isPresent(
            world.driver, find.byValueKey(component)),
        true);
  }

  @override
  RegExp get pattern => RegExp(r"the component {string} is shown");
}

class ClickComponent extends Then1WithWorld<String, FlutterWorld> {
  ClickComponent()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String component) async {
    await world.driver!.tap(find.byValueKey(component));
  }

  @override
  RegExp get pattern =>
      RegExp(r"I should be able to click the {string} button");
}
