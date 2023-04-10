import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/home_step.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = ["features/home.feature"]
    ..reporters = [StdoutReporter()]
    ..stepDefinitions = [OnHomePage(), CheckCameraPreview()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/app.dart";
  return GherkinRunner().execute(config);
}
