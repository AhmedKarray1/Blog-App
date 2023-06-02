import 'package:flutter/cupertino.dart';

class Comment{
  final int id;
  final String name;
  final String body;
  
  final int postId;
  Comment({ @required  this.id,@required this.name,@required this.body,@required this.postId});

 @override
  String toString() {
    return 'Comment { id: $id, name: $name, body: $body, postId: $postId }';
  }



}