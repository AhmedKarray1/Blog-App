import 'package:flutter/material.dart';
import 'package:test_technique1/models/comment.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName='/postScreen';
   
   
  

  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    final postId=routeArgs['id'];
    final postTitle=routeArgs['title'];
    final postBody=routeArgs['body'];
    final comments=routeArgs['comments']  as List;


    return Scaffold(appBar: AppBar(

      title: Text(postTitle),
      



    ),
    body: Column(children: [
      Container(height: MediaQuery.of(context).size.height*0.25,
      width: MediaQuery.of(context).size.width*0.8,
      margin: EdgeInsets.symmetric(vertical: 20 ,horizontal:MediaQuery.of(context).size.width*0.1 ),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.35)

      ),
      child: Stack(children: [
        Align(alignment: Alignment.topCenter,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[Container(
            margin: EdgeInsets.only(top: 20,left: 20),
            
            
            child: Text(postTitle)),Container(

              margin: EdgeInsets.only(top:20 ,right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
              ),
              
              
              child: Icon(Icons.bookmark,color: Colors.white,))]),),
          Align(alignment: Alignment.center,
          child: Container(child: Text('body'),),

          
          
          
          
          )







      ]),

      
      
      
      
      
      
      
      
      
      
      ),
      Container()





    ],));
  }
}