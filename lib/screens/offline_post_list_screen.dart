import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_technique1/Providers/posts_provider.dart';

import 'package:test_technique1/widgets/post_ui.dart';

class OfflinePostListScreen extends StatefulWidget {
  @override
  State<OfflinePostListScreen> createState() => _OfflinePostListScreenState();
}

class _OfflinePostListScreenState extends State<OfflinePostListScreen> {
  @override
  Widget build(BuildContext context) {
    final savedposts =
        Provider.of<postsProvider>(context, listen: false).local_saved_posts;

    return Scaffold(
      body: (savedposts == [])
          ? Center(
              child: Text("no saved posts!"),
            )
          : ListView.builder(
              itemBuilder: ((context, index) => PostUi(
                  id: savedposts[index].id,
                  title: savedposts[index].title,
                  body: savedposts[index].body,
                  comments: savedposts[index].comments,
                  preview: savedposts[index].body.length <= 20
                      ? savedposts[index].body
                      : savedposts[index].body.substring(0, 20))),
              itemCount: savedposts.length,
            ),
    );
  }
}
