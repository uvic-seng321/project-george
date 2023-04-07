
import 'package:flutter/material.dart';
import 'backend.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final List<Post> _posts = [
  ];

  final ScrollController _scrollController = ScrollController();

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    // Simulate loading data from a generic source
    await Future.delayed(const Duration(seconds: 2));
    final newPosts = List.generate(100, (index) => Post(tags: [], latitude: (_posts.length + index + 1).toDouble(), longitude: 0.toDouble(), imageFile: 'This is the body of post ${_posts.length + index + 1}.'));
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
            title: Text(post.latitude.toString()),
            subtitle: Text(post.imageFile.toString()),
          );
        }
      },
    );
  }
}
