import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'steps/post_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('./features/*.feature')]
    ..reporters = [StdoutReporter()]
    ..stepDefinitions = [UploadPostPageStep()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "./test.dart";
  return GherkinRunner().execute(config);
}
