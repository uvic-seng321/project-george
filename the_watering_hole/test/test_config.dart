import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/posts_steps.dart';
import 'steps/upload_post_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('features/*.*.feature')]
    ..reporters = [StdoutReporter()]
    ..stepDefinitions = [
      testCreatePostStep(),
      addButton(),
      emptyLatitudeAndLongitude(),
      latitudeAndLongitudeAreInputted(),
      tagsSubmittedToInputField(),
      userFillsInAllRequiredFieldsButEntersNoImage(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}
