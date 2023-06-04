import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_technique1/Providers/posts_provider.dart';
import 'package:test_technique1/models/post.dart';
import 'package:test_technique1/widgets/post_ui.dart';

class OfflinePostListScreen extends StatelessWidget {
  
  List<Post> savedposts;
  OfflinePostListScreen(this.savedposts);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      
      body:((savedposts ==null)||(savedposts==[]))?Center(child: Text("no saved posts!"),):
      
      
        ListView.builder(itemBuilder: ((context, index) =>PostUi(id: savedposts[index].id, title:savedposts[index].title, body:savedposts[index].body, comments: savedposts[index].comments, preview: savedposts[index].body.substring(0,20))




     )
     

     
     
     
     ,itemCount:savedposts.length ,),
      



    );
  }
}