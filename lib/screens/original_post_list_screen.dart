import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/posts.dart';
import '../widgets/create_post.dart';
import '../widgets/post_ui.dart';

class OriginalPostListScreen extends StatelessWidget 
{

static const routeName='/originalpostListScreen';

  @override
  Widget build(BuildContext context) {
    final loadedPosts = Provider.of<Posts>(context);
    // print(loadedPosts.posts[0].comments.length);
    return Scaffold(
      body: Column(children: [
        CreatePost(),
          Container(
            margin: EdgeInsets.only(top: 0.01),
            height: 350,
            width: double.infinity,
            child: 
            Consumer<Posts>(
          builder: (context, postsProvider, _) =>ListView.builder(
              itemBuilder: ((context, index) => GestureDetector(
                child: PostUi(
                    id: postsProvider.posts[index].id,
                    title: postsProvider.posts[index].title,
                    body: postsProvider.posts[index].body,
                    comments: postsProvider.posts[index].comments,
                    preview: postsProvider.posts[index].body.substring(0, 20),
                    
                    
                    
                    ),
              )),

              itemCount: postsProvider.posts.length,
            ),
          ),
        )
      ]),
    );
  }
}
