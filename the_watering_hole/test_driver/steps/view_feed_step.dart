import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../pages/feed_page.dart';

class OnHomePage extends GivenWithWorld<FlutterWorld> {
  OnHomePage()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));
  @override
  Future<void> executeStep() async {
    await FlutterDriverUtils.isPresent(
        world.driver, find.byValueKey("FeedView"));
  }

  @override
  RegExp get pattern => RegExp(r"I am on the home page");
}

class PressButton extends When1WithWorld<String, FlutterWorld> {
  PressButton()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));
  @override
  Future<void> executeStep(String button) async {
    await world.driver!.tap(find.byValueKey(button));
  }

  @override
  RegExp get pattern => RegExp(r"I press the {string} button");
}

class ShouldSeeImage extends Then1WithWorld<int, FlutterWorld> {
  ShouldSeeImage()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 15));
  @override
  Future<void> executeStep(int amnt) async {
    FeedPage page = FeedPage(world.driver!);
    var image = page.findAnyImage();
    expect(
        await FlutterDriverUtils.isPresent(world.driver, image,
            timeout: const Duration(seconds: 10)),
        true);
  }

  @override
  RegExp get pattern => RegExp(r"I should see at least {int} image(s)");
}

class OnFeedScreen extends GivenWithWorld<FlutterWorld> {
  OnFeedScreen()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 3));
  @override
  Future<void> executeStep() async {
    await world.driver!.tap(find.byValueKey("FeedViewButton"));
    FeedPage page = FeedPage(world.driver!);
    expect(
        await FlutterDriverUtils.isPresent(world.driver, page.getPage()), true);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the feed screen");
}

class FocussedInFeed extends When1WithWorld<String, FlutterWorld> {
  FocussedInFeed()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));
  @override
  Future<void> executeStep(String component) async {
    await world.driver!.tap(find.byValueKey(component));
  }

  @override
  RegExp get pattern => RegExp(r"I am focussed on the {string} component");
}

class ScrollDown extends Then2WithWorld<double, String, FlutterWorld> {
  ScrollDown()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));
  @override
  Future<void> executeStep(double dy, String component) async {
    FeedPage page = FeedPage(world.driver!);
    await page.scrollDown(dy);
  }

  @override
  RegExp get pattern => RegExp(
      r"I should be able to scroll with offset {double} in the {string} component");
}

class EnterTagIntoInput extends When1WithWorld<String, FlutterWorld> {
  EnterTagIntoInput()
      : super(StepDefinitionConfiguration()
          ..timeout = const Duration(seconds: 10));
  @override
  Future<void> executeStep(String tag) async {
    FeedPage page = FeedPage(world.driver!);
    await page.search(tag);
  }

  @override
  RegExp get pattern => RegExp(r"I enter {string} into the search input");
}
