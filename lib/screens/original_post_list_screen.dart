
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/posts.dart';
import '../widgets/create_post.dart';
import '../widgets/post_ui.dart';

class OriginalPostListScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final loadedPosts=Provider.of<Posts>(context);
    return Scaffold(body:
    Column(children: [
          
          CreatePost(),
          
          Container(
            margin: EdgeInsets.only(top:0.01),
            height: 350,
          width: double.infinity,
    
          child: 
          ListView.builder(itemBuilder:((context, index) => PostUi(id: loadedPosts.posts[index].id, title: loadedPosts.posts[index].title, body: loadedPosts.posts[index].body, comments: loadedPosts.posts[index].comments, preview: loadedPosts.posts[index].body.substring(0,20))) ,itemCount:loadedPosts.posts.length ,),
          )]) ,);
  }
}





