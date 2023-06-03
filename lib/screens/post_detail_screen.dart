import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_technique1/Providers/posts_provider.dart';

import 'package:test_technique1/screens/comments_screen.dart';
import 'package:test_technique1/widgets/comment_ui.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName = '/postScreen';

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<postsProvider>(context, listen: false);
    

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final postId = routeArgs['id'];
    final postTitle = routeArgs['title'];
    final postBody = routeArgs['body'];
    final comments = routeArgs['comments'] as List;
    print(postTitle);

    return Scaffold(
        appBar: AppBar(
          title: Text("Post Detail"),
          backgroundColor: Colors.pink,
        ),
        body: Consumer<postsProvider>(
          builder: (context, value, child) => 

           Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              decoration: BoxDecoration(color: Colors.pink.withOpacity(0.5)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 40,
                            width: 250,
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              postTitle,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )),
                        GestureDetector(
                          onTap: () {
                            posts.toggleSavedStatus(postId);
                            posts.setPosts(postTitle, postBody);

                            // print(posts.savedposts);
        
                            // print(post.isSaved);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pink,
                            ),
                            height: 40,
                            width: 40,
                            child: posts.posts
                                    .firstWhere((post) => post.id == postId)
                                    .isSaved
                                ? Icon(
                                    Icons.bookmark,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          postBody,
                          style: TextStyle(fontSize: 13),
                        )),
                  ),
                ],
              ),
            ),
            ((comments == null)||(comments==[]))
                ? Center(child: Text("no comment yet"))
                : Column(
                    children: [
                      CommentUi(
                          comments[0]
                              .email
                              .substring(0, comments[0].email.indexOf('@')),
                          comments[0].body),
                      CommentUi(
                          comments[1]
                              .email
                              .substring(0, comments[1].email.indexOf('@')),
                          comments[1].body),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  CommentsScreen.routeName,
                                  arguments: comments);
                            },
                            icon: Icon(Icons.comment),
                            label: Text("see all comments"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink),
                            ),
                          ))
                    ],
                  )
          ]),
        ));
  }
}
