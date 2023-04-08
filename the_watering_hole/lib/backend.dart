import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:flutter/material.dart';

void main() async {
  var post = Post(
      874,
      ["tag1", "tag2"],
      1.2,
      1.0,
      File(
          "/Users/christianbookout/Desktop/courses/seng321/project-george/the_watering_hole/api/test/test_images/peacock.png"));
  // uploadPost(post);
  // var image = await getImage(874);
  uploadPost(post);
  // var posts = await getPosts();
  // print("Posties: " + posts.toString());
  // print("Image size is ${image.height}");
  // print(getPosts());
}

class Post {
  int id;
  List<String> tags;
  double latitude;
  double longitude;
  File? imageFile;
  DateTime? date;
  int? poster;
  int? views;

  Post(this.id, this.tags, this.latitude, this.longitude,
      [this.imageFile, this.date, this.poster, this.views]);

  @override
  String toString() {
    return "Post(id: $id, tags: $tags, latitude: $latitude, longitude: $longitude, imageFile: $imageFile, date: $date, poster: $poster, views: $views)";
  }
}

// Future<Image> getImage(int postID) async {
//   var request = Uri.http(
//       '192.168.1.84:5000', 'posts/getImage', {'id': postID.toString()});
//   var response = await http.get(request);
//   if (response.statusCode == 200) {
//     return Image.memory(base64Decode(response.body));
//   } else {
//     throw Exception("Failed to get image. Response: $response");
//   }
// }

Future<void> uploadPost(Post post) async {
  if (post.imageFile == null) {
    throw Exception("No image file was provided");
  }
  // var fileBytes = await post.imageFile!.openRead();
  var bytes = await post.imageFile!.readAsBytes();
  var image = base64Encode(bytes);
  var uri = Uri.http('192.168.1.84:5000', 'posts/uploadPost');
  var request = http.MultipartRequest("POST", uri)
    ..fields.addAll({
      'latitude': post.latitude.toString(),
      'longitude': post.longitude.toString(),
      'user': '1', // TODO user id
      'tags': jsonEncode(post.tags),
      'image': image,
    });
  var response = await request.send();
  if (response.statusCode == 400) {
    throw Exception("A parameter has been inputted incorrectly");
  } else if (response.statusCode != 200) {
    throw Exception("Failed to upload post");
  }
}

// Get all posts from the server. Optional arguments of tags, latitude,
// longitude, and radius can be passed in to filter the posts.
//
Future<List<Post>> getPosts(
    {int? pageNum,
    List<String>? tags,
    Float? latitude,
    Float? longitude,
    Float? radius}) async {
  var queryParams = {
    "tags": tags,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "pageNum": pageNum,
  }..removeWhere((_, value) => value == null);
  var url = Uri.http('0.0.0.0:5000', '/posts/getPosts', queryParams);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    List<Post> posts = <Post>[];
    for (var v in json) {
      posts.add(Post(
          v["id"],
          [],
          v["latitude"],
          v["longitude"],
          null,
          DateTime.now(), // TODO time
          v["poster"],
          v["views"]));
    }
    return posts;
  } else if (response.statusCode == 400) {
    throw Exception(
        "A parameter has been inputted incorrectly. Response: $response");
  } else {
    throw Exception("Failed to get posts. Response: $response");
  }
}
