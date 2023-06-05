import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/widgets/new_post.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test_technique1/widgets/update_post.dart';

import '../Providers/posts_provider.dart';

import '../widgets/post_ui.dart';

class OriginalPostListScreen extends StatefulWidget {
  static const routeName = '/originalpostListScreen';

  @override
  State<OriginalPostListScreen> createState() => _OriginalPostListScreenState();
}

class _OriginalPostListScreenState extends State<OriginalPostListScreen> {
  late Function addpost;

  void addNewPost(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewPost();
        });
  }

  @override
  Widget build(BuildContext context) {
    final loadedPosts = Provider.of<PostsProvider>(context);
    loadedPosts.checkConnectivity();

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        
        body:
         (loadedPosts.connectivityResult==ConnectivityResult.none)
            ? 
         Center(
            child: Text("you are offline !",style: TextStyle(
                          color: Colors.pink,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),),
          ):
          Column(children: [
      GestureDetector(
        onTap: () => addNewPost(context),
        child: Container(
          margin: EdgeInsets.all(width * 0.1),
          width: width * 0.8,
          height: height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: Colors.pink,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height: height * 0.073,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Create new post",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 0.01),
        height: 350,
        width: double.infinity,
        child: Consumer<PostsProvider>(
          builder: (context, postsProvider, _) => ListView.builder(
            itemBuilder: ((context, index) => GestureDetector(
                  child: PostUi(
                    id: postsProvider.posts[index].id,
                    title: postsProvider.posts[index].title,
                    body: postsProvider.posts[index].body,
                    comments: postsProvider.posts[index].comments,
                    preview: postsProvider.posts[index].body.length <= 20
                        ? postsProvider.posts[index].body
                        : postsProvider.posts[index].body.substring(0, 20),
                  ),
                )),
            itemCount: postsProvider.posts.length,
          ),
        ),
      ),
    ])
        );
  }
}
