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
              postId: obj["postId"],
              email: obj["email"]));
        }
        _comments = loadedComment;
        loadedPosts.add(Post(
            id: post["id"],
            title: post["title"],
            body: post["body"],
            comments: _comments));
      }
      _posts = loadedPosts;
    } catch (error) {
      print(error);
    }
  }

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> deletePost(int id) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");
    print("enter delete");
    final existingPostIndex =
        _posts.indexWhere((element) => element.id == id);
    var existingPost = _posts[existingPostIndex];
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
   
    final response = await http.delete(url);
    print(response.body);
    if (response.statusCode >= 400) {
      print("erreur");
      _posts.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('could not delete post');
    }
    existingPost = null;
  }

  List<Post> get savedPosts {
    return _posts.where((element) => element.isSaved).toList();
  }

  Post findById(int id) {
    return _posts.firstWhere((post) => post.id == id);
  }
  //  void toggleSavedStatus(int id) {

  //   notifyListeners();
  // }
  Future<void> createPost(Post post) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    try {
      final response = await http.post(url,
          body: json.encode({'title': post.title, 'body': post.body}));
      final newPost =
          Post(id: _posts.length, title: post.title, body: post.body);
      _posts.add(newPost);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updatePost(int id, Post newPost) async {
    final postIndex = _posts.indexWhere((post) => post.id == id);
    if (postIndex >= 0) {
      final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");
      await http.patch(url,
          body: json.encode({
            'title': newPost.title,
            'Body': newPost.body,
          }));
      _posts[postIndex] = newPost;
      notifyListeners();
    } else {
      print('not existing post');

    }
  }
    void toggleSavedStatus(int id) {

      var indexPost=_posts.indexWhere((post) => post.id==id);
      _posts[indexPost].isSaved=!_posts[indexPost].isSaved;


notifyListeners();
  }






}
