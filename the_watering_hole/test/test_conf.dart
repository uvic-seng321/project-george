import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('features/*.feature')]
    ..reporters = [StdoutReporter()]
    ..stepDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "./test.dart";
  return GherkinRunner().execute(config);
}
