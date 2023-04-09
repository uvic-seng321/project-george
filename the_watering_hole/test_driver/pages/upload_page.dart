import 'package:flutter_driver/flutter_driver.dart';

class UploadPage {
  final FlutterDriver _driver;

  UploadPage(this._driver);

  // Get the title of the page
  SerializableFinder getPage() {
    return find.byValueKey("UploadPage");
  }

  Future<void> enterText(String component, String value) async {
    await _driver.tap(find.byValueKey(component));
    return await _driver.enterText(value);
  }

  Future<bool> textIsPresent(String component, String value) async {
    var text = await _driver.getText(find.byValueKey(component));
    return text == value;
  }
}
