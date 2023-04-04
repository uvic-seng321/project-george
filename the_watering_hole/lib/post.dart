import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiURL = dotenv.env['API_URL']!;

class Post {
  List<String> tags;
  Float latitude;
  Float longitude;
  File imageFile;

  Post(this.tags, this.latitude, this.longitude, this.imageFile);

  // Upload a post to the server. Taken from:
  // https://stackoverflow.com/questions/44841729/how-to-upload-images-to-server-in-flutter
  Future<void> uploadPost() async {
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var uploadURL = "$apiURL/posts/uploadPost";
    var uri = Uri.parse(uploadURL);

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 400) {
      throw Exception("A parameter has been inputted incorrectly");
    } else if (response.statusCode != 200) {
      throw Exception("Failed to upload post. Response: $response");
    }
  }

  // Get all posts from the server. Optional arguments of tags, latitude,
  // longitude, and radius can be passed in to filter the posts.
  static Future<List<Post>> getPosts(
      {List<String>? tags,
      Float? latitude,
      Float? longitude,
      Float? radius}) async {
    var queryParams = {
      "tags": tags,
      "latitude": latitude,
      "longitude": longitude,
      "radius": radius
    }..removeWhere((_, value) => value == null);
    var url = Uri.https(apiURL, '/posts/getPosts', queryParams);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var posts = jsonResponse["posts"];
      return posts.map<Post>((post) => Post(post["tags"], post["latitude"],
          post["longitude"], File(post["imageFile"])));
    } else if (response.statusCode == 400) {
      throw Exception(
          "A parameter has been inputted incorrectly. Response: $response");
    } else {
      throw Exception("Failed to get posts. Response: $response");
    }
  }
}
