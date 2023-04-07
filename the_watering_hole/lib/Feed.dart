import 'package:flutter/material.dart';

class Post {
  final String title;
  final String body;

  Post({required this.title, required this.body});
}

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final List<Post> _posts = [
    Post(title: 'Post 1', body: 'This is the body of post 1.'),
    Post(title: 'Post 2', body: 'This is the body of post 2.'),
    Post(title: 'Post 3', body: 'This is the body of post 3.'),
    Post(title: 'Post 4', body: 'This is the body of post 4.'),
    Post(title: 'Post 5', body: 'This is the body of post 5.'),
    Post(title: 'Post 6', body: 'This is the body of post 6.'),
    Post(title: 'Post 7', body: 'This is the body of post 7.'),
    Post(title: 'Post 8', body: 'This is the body of post 8.'),
    Post(title: 'Post 9', body: 'This is the body of post 9.'),
    Post(title: 'Post 10', body: 'This is the body of post 10.'),
  ];

  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    // Simulate loading data from a generic source
    await Future.delayed(Duration(seconds: 2));
    final newPosts = List.generate(10, (index) => Post(title: 'Post ${_posts.length + index + 1}', body: 'This is the body of post ${_posts.length + index + 1}.'));
    setState(() {
      _posts.addAll(newPosts);
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _posts.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _posts.length) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final post = _posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        }
      },
    );
  }
}
