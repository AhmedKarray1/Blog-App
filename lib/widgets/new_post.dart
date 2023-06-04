import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/models/post.dart';
import 'package:test_technique1/Providers/posts_provider.dart';

class NewPost extends StatelessWidget {
  // final int id;
  // NewPost(this.id);
  final _titlecontroller = TextEditingController();

  final _bodycontroller = TextEditingController();

  void _submitData(BuildContext context) async {
    (context);
    final enteredTitle = _titlecontroller.text;
    final enteredBody = _bodycontroller.text;
    if ((enteredTitle.isEmpty) || enteredBody.isEmpty) {
      return;
    }
    var newPost =
        Post(id: 0, title: enteredTitle, body: enteredBody, comments: []);
    Navigator.of(context).pop();
    await Provider.of<postsProvider>(context, listen: false)
        .createPost(newPost);
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<postsProvider>(context);

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
                controller: _titlecontroller,
                onSubmitted: (_) => _submitData(context),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Body:',
                  labelStyle: TextStyle(
                      color: Colors.pink,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                controller: _bodycontroller,
                onSubmitted: (_) => _submitData(context),
              ),
              ElevatedButton(
                  onPressed: () => _submitData(context),
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
