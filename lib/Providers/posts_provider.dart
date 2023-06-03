import 'dart:convert';
import 'dart:ffi';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:test_technique1/models/comment.dart';
import 'package:test_technique1/Providers/post.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tuple/tuple.dart';

class postsProvider with ChangeNotifier {
  List<Post> _posts = [];
  Future<Void?> fetchPosts() async {
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
      
      throw(error);
    }
  }

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> deletePost(int id) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");
    print("enter delete");
    final existingPostIndex = _posts.indexWhere((element) => element.id == id);
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
    
  }

  Future<void> createPost(Post post) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    try {
      final response = await http.post(url,
          body: json.encode({'id':_posts.length,'title': post.title, 'body': post.body}));
      final responseData = json.decode(response.body);

      final newPost = Post(
          id: _posts.length, title: post.title, body: post.body, comments: []);
      _posts.indexOf(newPost,0);

      print(_posts.length);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updatePost(int id, Post newPost) async {
    final postIndex = _posts.indexWhere((post) => post.id == id);
    if (postIndex >= 0) {
      _posts[postIndex] = newPost;
      final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");
      
      await http.patch(url,
          body: json.encode({
            'id':newPost.id,
            'title': newPost.title,
            'Body': newPost.body,
          }));
      
      notifyListeners();
    } else {
      print('not existing post');
    }
  }

  List<Post> _savedposts = [];

  void toggleSavedStatus(int id) {
    var indexPost = _posts.indexWhere((post) => post.id == id);
    _posts[indexPost].isSaved = !_posts[indexPost].isSaved;
    if (_posts[indexPost].isSaved) {
      _savedposts.add(_posts[indexPost]);
    } else {
      if (_savedposts.contains(_posts[indexPost])) {
        _savedposts.remove(_posts[indexPost]);
      }
    }
    // print(_savedposts);

    notifyListeners();
  }

  List<Post> get savedposts {
    return [..._savedposts];
  }

  Future<void> setPosts(String title, String body) async {
   
    List<String> titleSavedPost = [];

    for (var post in _savedposts) {
      titleSavedPost.add(post.title);
    }
    titleSavedPost.add(title);

    List<String> bodySavedPost = [];

    for (var post in savedposts) {
      bodySavedPost.add(post.body);
    }
    bodySavedPost.add(body);
print("ahmedfinn");
    SharedPreferences pref_title = await SharedPreferences.getInstance();
     

    pref_title.setStringList('title', titleSavedPost);
    SharedPreferences pref_body = await SharedPreferences.getInstance();

    pref_body.setStringList('body', bodySavedPost);
  
    print(titleSavedPost);
    notifyListeners();
  }

  List<dynamic> local_saved_posts=[];
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var titles = prefs.getStringList('title');
    var bodies = prefs.getStringList('body');
    // mergeLists(titles, bodies);
    notifyListeners();
  }
Post findById(int id)
{return _posts.firstWhere((post) => post.id==id);

}

 
}
