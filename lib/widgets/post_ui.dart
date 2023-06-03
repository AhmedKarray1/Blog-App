import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/posts_provider.dart';
import 'package:test_technique1/models/comment.dart';
import 'package:test_technique1/screens/post_detail_screen.dart';

class PostUi extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  final List<Comment> comments;

  final String preview;

  
  PostUi(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.comments,
      @required this.preview
      ,
      });

  @override
  Widget build(BuildContext context) {
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
        height: 90,
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.3),
          // borderRadius:BorderRadius.circular(20)
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: 
              
             
                 Column(
                   children: [
                     GestureDetector(
                      onTap: (() {
                        Provider.of<postsProvider>(context,listen: false).deletePost(id);
                      }),
                       child: Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        height: 30,
                        width: 30,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 25,
                        ),
                                     ),
                     ),
                      GestureDetector(
                      onTap: (() {
                        
                      }),
                       child: Container(
                        margin: EdgeInsets.only(right: 10, top: 10,bottom: 10),
                        height: 30,
                        width: 30,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
                        child: Icon(
                          Icons.update,
                          color: Colors.white,
                          size: 25,
                        ),
                                     ),
                     ),

                   ],
                 ),
              
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 8),
                height: 50,
                width: 180,
                child: Text(
                  this.title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 8),
                height: 50,
                width: 300,
                child: Text(
                  '${this.preview}...',
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
