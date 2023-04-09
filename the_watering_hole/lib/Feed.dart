import 'dart:ffi';
import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'backend.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> _posts = [];
  List<String> _filters = [];
  int page = 1;

  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    page = 1;
    _loadMorePosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      page++;
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    // Simulate loading data from a generic source
    print("page ${page}");
    List<Post> newPosts = await getPosts(pageNum: page, tags: _filters);
    setState(() {
      _posts.addAll(newPosts);
      _isLoadingMore = false;
    });
  }

  void _filterPosts(String query) {
    setState(() {
      _filters.add(query);
    });
    page = 1;
    mapOut = {};
    _posts = [];
    _loadMorePosts();
  }

  Map<int, Image> mapOut = {};
  Future<Map<int, Image>> imMap(List<Post> posts) async {
    for (int i = 5*(page-1); i < posts.length; i++) {
      if (posts.isEmpty) {
        break;
      }
      mapOut[posts[i].id] = await getImage(posts[i].id);
    }
    return mapOut;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) => _filterPosts(value),
        ),
      ),
      SizedBox(
        height: 100,
        child: ListView.builder(
            itemCount: _filters.length,
            itemBuilder: (context, index) {
              final item = _filters[index];
              return ListTile(
                title: Text(item),
              );
            }),
      ),
      Expanded(
        child: postList(),
      )
    ]);
  }

  Widget postList() {
    return FutureBuilder(
      future: imMap(_posts),
      builder: (BuildContext context, AsyncSnapshot<Map<int, Image>> snapshot) {
        return ListView.builder(
            controller: _scrollController,
            itemCount: _posts.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final post = _posts[index];
                return ListTile(
                  title: Text(post.id.toString()),
                  subtitle: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 0,
                      minWidth: 0,
                      maxHeight: 100000,
                      maxWidth: 100000,
                    ),
                    child: test(snapshot, post),
                  ),
                );
              }
            });
      },
    );
  }

  Image? test(snapshot, post) {
    if (snapshot.hasData == true) {
      return snapshot.data[post.id];
    } else {
      return null;
    }
  }
}
