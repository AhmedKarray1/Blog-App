import 'package:flutter/material.dart';
import 'package:test_technique1/models/comment.dart';
import 'package:test_technique1/screens/comments_screen.dart';
import 'package:test_technique1/widgets/comment_ui.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName='/postScreen';
   
   
  

  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    final postId=routeArgs['id'];
    final postTitle=routeArgs['title'];
    final postBody=routeArgs['body'];
    final comments=routeArgs['comments'] as List ;
    print(comments[0]);
   
    
    
    


    return Scaffold(appBar: AppBar(

      title: Text("Post Detail"),
      
backgroundColor: Colors.pink,


    ),
    body: Column(children: [
      Container(height: MediaQuery.of(context).size.height*0.25,
      width: MediaQuery.of(context).size.width*0.8,
      margin: EdgeInsets.symmetric(vertical: 20 ,horizontal:MediaQuery.of(context).size.width*0.1 ),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.5)),
      child: Stack(children: [
        Align(alignment: Alignment.topCenter,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[Container(
            height: 40,
            width: 250,
            
            margin: EdgeInsets.only(top: 20,left: 20),
            child: Text(postTitle,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),)),Container(
              margin: EdgeInsets.only(top:10 ,right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
              ),
              height: 40,
                width: 40,
              child: Icon(Icons.bookmark,color: Colors.white,))]),),
          Align(alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(20),
            
            child: Text(postBody,style: TextStyle(fontSize: 13),)),),

            
            
            
            
            
            
            ]
          ),),
          Column(
            children: [CommentUi(comments[0].email.substring(0,comments[0].email.indexOf('@')), comments[0].body),
            CommentUi(comments[1].email.substring(0,comments[1].email.indexOf('@')), comments[1].body),
            Container(
              margin: EdgeInsets.only(top: 20),

              
              child: ElevatedButton.icon(onPressed: (){
                Navigator.of(context).pushNamed(CommentsScreen.routeName,arguments: comments);


              }, icon:Icon(Icons.comment),
               label: Text("see all comments"),
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.pink ),
              
              
              
              
              ),
            ))
            
            
            ],
            
            
            
            
            )

          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10,horizontal:20 ),
          //   height: MediaQuery.of(context).size.height*0.5,
          // width: MediaQuery.of(context).size.width*0.7,
          
          // child: ListView.builder(
          //   itemCount:comments.length ,
          //   itemBuilder: (BuildContext context, int index) {
          //     final comment=comments[index];
          //     return ;
          //   },
          // ),



          
          // )
          
          
          ]
          )
          );

      
  }}