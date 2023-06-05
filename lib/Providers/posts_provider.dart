import 'dart:convert';
import 'dart:ffi';

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_technique1/models/comment.dart';
import 'package:test_technique1/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostsProvider with ChangeNotifier {
  List<Post> _posts = [];
  Future<Void?> fetchPosts() async {
    final client = http.Client();

    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    try {
      final response = await client.get(url);
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
      throw (error);
    }

    client.close();
  }

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> deletePost(int id) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");

    final existingPostIndex = _posts.indexWhere((element) => element.id == id);
    var existingPost = _posts[existingPostIndex];
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _posts.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('could not delete post');
    }
  }

  Future<void> createPost(Post post) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    try {
      final newPost = Post(
          id: _posts.length + 1,
          title: post.title,
          body: post.body,
          comments: []);
      _posts.add(newPost);
      final response = await http.post(url,
          body: json.encode({
            'id': post.id,
            'title': post.title,
            'body': post.body,
            'comments': post.comments
          }));
      final responseData = json.decode(response.body);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updatePost(int id, Post newPost) async {
    final postIndex = _posts.indexWhere((post) => post.id == id);
    if (postIndex >= 0) {
      _posts[postIndex] = newPost;
      notifyListeners();
      final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");

      await http.patch(url,
          body: json.encode({
            'id': newPost.id,
            'title': newPost.title,
            'Body': newPost.body,
          }));
    } else {
      print('not existing post');
    }
  }

  bool isPostSaved(String postTitle, List<Post> postsProvider) {
    for (var savedPost in postsProvider) {
      if (savedPost.title == postTitle) {
        return true;
      }
    }
    return false;
  }

  List<Post> _savedposts = [];
  List<Post> local_saved_posts = [];
  void toggleSavedStatus(String title) {
    var indexPost = _posts.indexWhere((post) => post.title == title);
    var postTitle = _posts[indexPost].title;

    if (isPostSaved(postTitle, local_saved_posts)) {
      _posts[indexPost].isSaved = false;
    } else {
      _posts[indexPost].isSaved = true;
    }

    if (_posts[indexPost].isSaved) {
      _savedposts.add(_posts[indexPost]);
      local_saved_posts.add(Post(
          id: local_saved_posts.length + 1,
          title: _posts[indexPost].title,
          body: _posts[indexPost].body,
          comments: []));
    } else {
      if ((_savedposts.contains(_posts[indexPost])) &&
          (local_saved_posts.any(
              (savedPost) => savedPost.title == _posts[indexPost].title))) {
        _savedposts.remove(_posts[indexPost]);
        local_saved_posts
            .removeWhere((post) => post.title == _posts[indexPost].title);
      }
    }

    notifyListeners();
  }

  List<Post> get savedposts {
    return [..._savedposts];
  }

  Future<void> setPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> titleSavedPost = prefs.getStringList('title') ?? [];

    List<String> bodySavedPost = prefs.getStringList('body') ?? [];

    await prefs.remove('title');
    await prefs.remove('body');
    titleSavedPost.add(_savedposts[_savedposts.length - 1].title);
    bodySavedPost.add(_savedposts[_savedposts.length - 1].body);

    await prefs.setStringList('title', titleSavedPost);

    await prefs.setStringList('body', bodySavedPost);

    notifyListeners();
  }

  Future<void> loadData() async {
    local_saved_posts = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var titles = prefs.getStringList('title');
    var bodies = prefs.getStringList('body');
    if ((titles != null) && (bodies != null)) {
      for (var i = 0; i < titles.length; i++) {
        local_saved_posts.add(
            Post(id: i + 1, title: titles[i], body: bodies[i], comments: []));
      }
    }

    notifyListeners();
  }

  Post findById(int id) {
    return _posts.firstWhere((post) => post.id == id);
  }

  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Future<void> checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    notifyListeners();
  }

  Future<void> deleteSavedPost(
      int id, String postTitle, String postBody) async {
    local_saved_posts.removeWhere((savedPost) => savedPost.id == id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listTitle = prefs.getStringList('title') ?? [];
    List<String> listBody = prefs.getStringList('body') ?? [];
    listTitle.removeWhere((title) => title == postTitle);
    listBody.removeWhere((body) => body == postBody);
    prefs.setStringList('title', listTitle);
    prefs.setStringList('body', listBody);
    notifyListeners();
  }
}
