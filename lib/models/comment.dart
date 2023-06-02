import 'package:flutter/cupertino.dart';

class Comment{
  final int id;
  final String name;
  final String body;
  final String email;
  
  final int postId;
  Comment({ @required  this.id,@required this.name,@required this.body,@required this.postId,@required this.email});

 @override
  String toString() {
    return 'Comment { id: $id, name: $name, body: $body, postId: $postId ,email:$email}';
  }



}