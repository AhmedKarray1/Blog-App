// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart';
// import 'package:test_technique1/models/comment.dart';
// import 'package:http/http.dart' as http;
// class Comments with ChangeNotifier{
//   List<Comment> _comments=[];
//   Future <void> fetchComments(String id)async{
//     final url=Uri.parse("https://jsonplaceholder.typicode.com/posts/$id/comments");

//    try{
//     print("ahmed");
//     print(url);
//     final response=await http.get(url);
//     final List<Comment> loadedComment=[];
//     final extractedData= json.decode(response.body);
//     if (extractedData==null){print("vide");
//     return;}
//     for(var obj in extractedData)
//     {loadedComment.add(Comment(id: obj["id"], name: obj["name"], body: obj["body"], postId: obj['postId']));




//     }
    

//     print(loadedComment[0]);
//     notifyListeners();

//    }
//    catch(error){
//     print(error);


//    }







//   }










// }