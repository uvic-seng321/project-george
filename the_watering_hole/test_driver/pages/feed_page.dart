import 'package:flutter_driver/flutter_driver.dart';

class FeedPage {
  final FlutterDriver _driver;

  FeedPage(this._driver);

  // Get the title of the page
  SerializableFinder getPage() {
    return find.byValueKey("FeedPage");
  }

  SerializableFinder findAnyImage() {
    return find.byValueKey("image");
  }

  // Scroll down the page
  Future<void> scrollDown(double units) async {
    return await _driver.scroll(find.byValueKey("FeedPage"), 0, units,
        const Duration(milliseconds: 500));
  }

  // Search for a post by tag
  Future<void> search(String value) async {
    await _driver.tap(find.byValueKey("SearchBar"));
    await _driver.enterText(value);
  }
}
