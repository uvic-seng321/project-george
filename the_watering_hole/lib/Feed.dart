
import 'dart:ffi';
import 'dart:io';

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
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
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
    _loadMorePosts();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            }
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: 1,//_posts.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final post = _posts[index];
                return postTile(post);
              }
            }
          )
        )
      ]
    );
  }

  Widget postTile(Post post) {
    return FutureBuilder(
      future: getImage(post.id),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        return ListTile(
          title: Text(post.id.toString()),
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
              minWidth: 0,
              maxHeight: 100000,
              maxWidth: 100000,
            ),
            child: snapshot.data,
          ),
        );
      },
    );
  }
}