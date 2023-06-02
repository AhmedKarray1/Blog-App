import 'package:flutter/material.dart';
import 'package:test_technique1/widgets/comment_ui.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName='/commentScreen';
  

  @override
  Widget build(BuildContext context) {
    final comments=ModalRoute.of(context).settings.arguments as List;
  
    return Scaffold(appBar: AppBar(
      title: Text("All Comments"),
      backgroundColor: Colors.pink,
      




    ),
    body: ListView.builder(itemBuilder:((context, index) {
      return CommentUi(comments[index].email.substring(0,comments[index].email.indexOf('@')), comments[index].body);




    } ) ,itemCount:comments.length ,),





    );
  }
}