import 'dart:ffi';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

// TODO: we need to somehow set up the upload form before we can test it,
// this would be done by adding default information to all fields maybe?

// the user presses the "add image" button and selects an image with URL "test_images/sheep.png"
StepDefinitionGeneric addButton() {
  return when2<String, String, FlutterWorld>(
    'the user presses the {string} button and selects an image with URL {string}',
    (imageButton, imageURL, context) async {
      final imageButtonLocator = find.byValueKey(imageButton);
      // Test if the add image button is present
      await FlutterDriverUtils.isPresent(
          context.world.driver, imageButtonLocator);
      // TODO add the image to the upload form somehow
    },
  );
}

// the user has entered nothing in the "latitudeInput" and "longitudeInput" fields
StepDefinitionGeneric emptyLatitudeAndLongitude() {
  return when2<String, String, FlutterWorld>(
    'the user has entered nothing in the "latitudeInput" and "longitudeInput" fields',
    (latInput, longInput, context) async {},
    // TODO ensure the latitude and longitude fields are empty
  );
}

// latitude <latitude> and longitude <longitude> are inputted in the
// "latitudeInput" and "longitudeInput" fields
StepDefinitionGeneric latitudeAndLongitudeAreInputted() {
  return when4<Float, Float, String, String, FlutterWorld>(
    'latitude {float} and longitude {float} are inputted in the {string} and {string} fields',
    (lat, long, latInput, longInput, context) async {
      final longLocator = find.byValueKey(latInput);
      final latLocator = find.byValueKey(longInput);
      await FlutterDriverUtils.enterText(
          context.world.driver, longLocator, long.toString());
      await FlutterDriverUtils.enterText(
          context.world.driver, latLocator, lat.toString());
    },
  );
}

// tag(s) <tag> are submitted to the "tagInput" field
StepDefinitionGeneric tagsSubmittedToInputField() {
  return when2<String, String, FlutterWorld>(
    'tag(s) {String} are submitted to the {string} field',
    (tagList, tagInput, context) async {
      final tagLocator = find.byValueKey(tagInput);
      await FlutterDriverUtils.enterText(
          context.world.driver, tagLocator, tagList);
    },
  );
}

// the user fills in all required fields but enters no image
StepDefinitionGeneric userFillsInAllRequiredFieldsButEntersNoImage() {
  return when<FlutterWorld>(
    'the user fills in all required fields but enters no image',
    (context) async {},
    // TODO not sure if we even need this step
  );
}

// StepDefinitionGeneric TapButtonNTimesStep() {
//   return when2<String, int, FlutterWorld>(
//     'I tap the {string} button {int} times',
//     (key, count, context) async {
//       final locator = find.byValueKey(key);
//       for (var i = 0; i < count; i += 1) {
//         await FlutterDriverUtils.tap(context.world.driver, locator);
//       }
//     },
//   );
// }
