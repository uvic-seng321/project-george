// ignore: avoid_relative_lib_imports
import 'package:flutter_test/flutter_test.dart';
import 'package:the_watering_hole/main.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
// import 'package:test/test.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  runApp(const MyApp());

  // test('Test - Main function return Normally', () {
  //   expect(() => flutter_bdd.main(), returnsNormally);
  // });
}
