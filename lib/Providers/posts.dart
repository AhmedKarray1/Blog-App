import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:test_technique1/models/comment.dart';
import 'package:test_technique1/Providers/post.dart';
import 'package:http/http.dart' as http;

class Posts with ChangeNotifier {
  List<Post> _posts = [];
  Future<Void> fetchPosts() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    try {
      final response = await http.get(url);
      final List<Post> loadedPosts = [];
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        exit(1);
      }
      for (var post in extractedData) {
        List<Comment> _comments = [];
        var id = post['id'];

        final url = Uri.parse(
            "https://jsonplaceholder.typicode.com/posts/$id/comments");
        final response = await http.get(url);
        final List<Comment> loadedComment = [];
        final extractedData = json.decode(response.body);
        if (extractedData == null) {
          print("vide");
          exit(1);
        }
        for (var obj in extractedData) {
          loadedComment.add(Comment(
              id: obj["id"],
              name: obj["name"],
              body: obj["body"],
              postId: obj['postId']));
        }
        _comments = loadedComment;
        loadedPosts.add(Post(
            id: post["id"],
            title: post["title"],
            body: post["body"],
            comments: _comments));
      }
      _posts = loadedPosts;
      print(_posts[4].title);
    } catch (error) {
      print(error);
    }
  }

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> deletePost(String id) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");
    final existingPostIndex =
        _posts.indexWhere((element) => (element.id).toString() == id);
        var existingPost=_posts[existingPostIndex];
        _posts.removeWhere((post)=> (post.id).toString()==id);
notifyListeners();
final response= await http.delete(url);
if(response.statusCode>=400)
{_posts.insert(existingPostIndex, existingPost);
notifyListeners();
 throw HttpException('could not delete post');
}
existingPost=null;



  }
}
