import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_photo_screen.dart';
import 'Feed.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class Post {
  List<String> tags;
  double latitude;
  double longitude;
  int id;

  Post({required this.tags, required this.latitude, required this.longitude, required this.id});
}