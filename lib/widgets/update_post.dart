import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/models/post.dart';
import 'package:test_technique1/Providers/posts_provider.dart';
import 'package:test_technique1/models/comment.dart';

class UpdatePost extends StatefulWidget {
  final int id;
  
  UpdatePost(this.id);

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  var initValues = {
    'id': null,
    'title': '',
    'body': '',
  };
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  @override
// var _isInit=true;
  void didChangeDependencies() {
    final editedPost = Provider.of<PostsProvider>(context).findById(widget.id);
    Map<String, dynamic> initValues = {
      'id': editedPost.id,
      'title': editedPost.title,
      'body': editedPost.body,
      'comments': editedPost.comments
    };
    titleController =
        TextEditingController(text: initValues['title'].toString());
    bodyController = TextEditingController(text: initValues['body'].toString());

    super.didChangeDependencies();
  }

  void _submitData(BuildContext context, int id, List<Comment> comments) {
    final enteredTitle = titleController.text;
    final enteredBody = bodyController.text;
    if ((enteredTitle.isEmpty) || enteredBody.isEmpty) {
      return;
    }
    var newPost = Post(
        id: id, title: enteredTitle, body: enteredBody, comments: comments);
    Navigator.of(context).pop();

    Provider.of<PostsProvider>(context, listen: false)
        .updatePost(widget.id, newPost);
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<PostsProvider>(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 16,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title:',
                  labelStyle: TextStyle(
                      color: Colors.pink,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                controller: titleController,
                onSubmitted: (_) => _submitData(
                    context, widget.id, posts.findById(widget.id).comments),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Body:',
                  labelStyle: TextStyle(
                      color: Colors.pink,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                controller: bodyController,
                onSubmitted: (_) => _submitData(
                    context, widget.id, posts.findById(widget.id).comments),
              ),
              ElevatedButton(
                  onPressed: () => _submitData(
                      context, widget.id, posts.findById(widget.id).comments),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                  ),
                  child: Text("submit"))
            ],
          ),
        ),
      ),
    );
  }
}
