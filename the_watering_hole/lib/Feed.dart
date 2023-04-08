
import 'package:flutter/material.dart';
import 'backend.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> _posts = [];
  List<String> _filters = ["TAG1"];
  var page = 1;

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
      page++;
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    // Simulate loading data from a generic source
    await Future.delayed(const Duration(seconds: 2));
    final newPosts = List.generate(100, (index) => Post(tags: List.generate(4, (index2) => "TAG${_posts.length+index+1}"), latitude: (_posts.length + index + 1).toDouble(), longitude: 0.toDouble(), id: _posts.length + index + 1));
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
          height: 50,
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
            itemCount: _posts.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final post = _posts[index];
                return ListTile(
                  title: Text(post.latitude.toString()),
                  subtitle: Text(post.id.toString()),
                );
              }
            }
          )
        )
      ]
    );
  }
}