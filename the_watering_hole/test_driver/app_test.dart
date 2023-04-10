import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/camera_page_step.dart' as camera;
import 'steps/view_feed_step.dart' as view;
import 'steps/upload_post_step.dart' as upload;

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/c**.feature")]
    ..reporters = [StdoutReporter(MessageLevel.debug)]
    ..stepDefinitions = [
      upload.CheckText(),
      upload.EnterText(),
      upload.OnCameraPage(),
      upload.OnUploadPage(),
      upload.PressButton(),
      upload.UploadImageScreen(),
      camera.OnCameraPage(),
      camera.LookAtPage(),
      camera.CheckCameraPreview(),
      camera.ComponentIsShown(),
      camera.ClickComponent(),
      view.OnHomePage(),
      view.PressButton(),
      view.ShouldSeeImage(),
      view.OnFeedScreen(),
      view.FocussedInFeed(),
      view.ScrollDown(),
      view.EnterTagIntoInput(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}
