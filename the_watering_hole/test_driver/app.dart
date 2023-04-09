// ignore: avoid_relative_lib_imports
import 'package:the_watering_hole/main.dart' as mainfile;
import 'package:flutter_driver/driver_extension.dart';
// import 'package:test/test.dart';

void main() async {
  // This line enables the extension
  enableFlutterDriverExtension();

  mainfile.main();
}
