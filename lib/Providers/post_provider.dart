import 'package:flutter/cupertino.dart';
import 'package:test_technique1/models/comment.dart';

class postProvider with ChangeNotifier {
  final int id;
  final String title;
  final String body;
  final List<Comment> comments;
  bool isSaved = false;
  postProvider(
      { @required this.id,
      @required this.title,
      @required this.body,
       @required this.comments,
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
