import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_photo_screen.dart';
import 'Feed.dart';
import 'dart:io';

class Post {
  List<String> tags;
  double latitude;
  double longitude;
  String imageFile;//File imageFile;

  Post({required this.tags, required this.latitude, required this.longitude, required this.imageFile});
}