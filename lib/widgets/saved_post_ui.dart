import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/posts_provider.dart';
import 'package:test_technique1/models/comment.dart';
import 'package:test_technique1/screens/post_detail_screen.dart';
import 'package:test_technique1/widgets/update_post.dart';

class SavedPostUi extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  final List<Comment> comments;

  final String preview;

  SavedPostUi({
    required this.id,
    required this.title,
    required this.body,
    required this.comments,
    required this.preview,
  });

  void updatePost(BuildContext ctx, int id, String title) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return UpdatePost(id);
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PostDetailScreen.routeName, arguments: {
          'id': id,
          'title': title,
          'body': body,
          'comments': comments,
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.04,
            horizontal: MediaQuery.of(context).size.width * 0.1),
        width: MediaQuery.of(context).size.width * 0.8,
        height: height * 0.138,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          color: Colors.pink.withOpacity(0.3),
          // borderRadius:BorderRadius.circular(20)
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (() {
                      Provider.of<PostsProvider>(context, listen: false)
                          .deleteSavedPost(id, title, body);
                    }),
                    child: Container(
                      margin: EdgeInsets.only(
                          right: width * 0.02, top: height * 0.02),
                      height: height * 0.087,
                      // height * 0.043,
                      width: width * 0.09,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.pink),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.011),
                height: height * 0.073,
                width: width * 0.43,
                child: Text(
                  this.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.pink),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding:
                    EdgeInsets.only(top: height * 0.043, left: width * 0.02),
                height: height * 0.073,
                width: width * 0.73,
                child: Text(
                  preview == body ? body : '${this.preview}...',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
