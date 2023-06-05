import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_technique1/Providers/posts_provider.dart';

import 'package:test_technique1/widgets/post_ui.dart';

import '../widgets/saved_post_ui.dart';

class OfflinePostListScreen extends StatefulWidget {
  @override
  State<OfflinePostListScreen> createState() => _OfflinePostListScreenState();
}

class _OfflinePostListScreenState extends State<OfflinePostListScreen> {
  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostsProvider>(context, listen: false);
    final localsavedposts = postsProvider.local_saved_posts;

    return Scaffold(
      body: (localsavedposts.isEmpty)
          ? Center(
              child: Text("no saved posts !",
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            )
          : ListView.builder(
              itemBuilder: ((context, index) => SavedPostUi(
                  id: localsavedposts[index].id,
                  title: localsavedposts[index].title,
                  body: localsavedposts[index].body,
                  comments: localsavedposts[index].comments,
                  preview: localsavedposts[index].body.length <= 20
                      ? localsavedposts[index].body
                      : localsavedposts[index].body.substring(0, 20))),
              itemCount: localsavedposts.length,
            ),
    );
  }
}
