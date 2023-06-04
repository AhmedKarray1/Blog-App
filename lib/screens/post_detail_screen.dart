import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_technique1/Providers/posts_provider.dart';

import 'package:test_technique1/screens/comments_screen.dart';
import 'package:test_technique1/widgets/comment_ui.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName = '/postScreen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final posts = Provider.of<postsProvider>(context, listen: false);

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final postId = routeArgs['id'];
    final postTitle = routeArgs['title'];
    final postBody = routeArgs['body'];
    final comments = routeArgs['comments'] as List;

    return Scaffold(
        appBar: AppBar(
          title: Text("Post Detail"),
          backgroundColor: Colors.pink,
        ),
        body: Consumer<postsProvider>(
          builder: (context, value, child) => Column(children: [
            Container(
              height: height * 0.25,
              width: width * 0.8,
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
                            height: height * 0.058,
                            width: width * 0.6,
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              postTitle,
                              style: TextStyle(
                                  color: Colors.pink.withOpacity(0.99),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                        GestureDetector(
                          onTap: () {
                            posts.toggleSavedStatus(postId);
                            posts.setPosts();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pink,
                            ),
                            height: height * 0.058,
                            width: width * 0.09,
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
            ((comments == null) || (comments.isEmpty))
                ? Center(
                    child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: height * 0.1,
                      horizontal: 0.1,
                    ),
                    child: Text(
                      "No Comments Yet !",
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
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
