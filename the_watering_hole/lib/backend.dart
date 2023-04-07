import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_photo_screen.dart';
import 'Feed.dart';
import 'dart:io';

class Post {
  List<String> tags;
  Float latitude;
  Float longitude;
  File imageFile;

  Post(this.tags, this.latitude, this.longitude, this.imageFile);
}