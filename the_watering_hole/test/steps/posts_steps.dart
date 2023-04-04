import 'dart:ffi';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:the_watering_hole/post.dart';

// a post with tag(s) <tag>, latitude <latitude>, longitude <longitude> and image url <url> is created
StepDefinitionGeneric testCreatePostStep() {
  return when4<String, Float, Float, String, FlutterWorld>(
    'a post with tag(s) {string}, latitude {float}, longitude {float} and image url {string} is created',
    (tags, latitude, longitude, imageURL, context) async {
      // read the image from the url
      var image = File(imageURL);
      var tagList = tags.split(',').map((tag) => tag.trim()).toList();

      Post(tagList, latitude, longitude, image);
    },
  );
}

// a post with tag(s) <tag>, latitude <latitude>, longitude <longitude> and image url <url> is created
StepDefinitionGeneric testUploadPostStep() {
  return then1(
    'a post with tag(s) {string}, latitude {float}, longitude {float} and image url {string} is created',
    (context) async {
      final imageButtonLocator = find.byValueKey(imageButton);
      // Test if the add image button is present
      await FlutterDriverUtils.isPresent(
          context.world.driver, imageButtonLocator);
      // TODO add the image to the upload form somehow
    },
  );
}
