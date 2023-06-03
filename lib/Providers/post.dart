import 'package:flutter/cupertino.dart';
import 'package:test_technique1/models/comment.dart';

class Post with ChangeNotifier {
  final int id;
  final String title;
  final String body;
  final List<Comment> comments;
  bool isSaved = false;
  Post(
      {@required this.id,
      @required this.title,
      @required this.body,
       this.comments,
      this.isSaved=false});
  // void toggleSavedStatus() {
  //   isSaved = !isSaved;
  //   notifyListeners();
  // }

  @override
  String toString() {
    return 'Post { id: $id, title: $title, body: $body, comments: $comments, isSaved: $isSaved }';
  }
}
