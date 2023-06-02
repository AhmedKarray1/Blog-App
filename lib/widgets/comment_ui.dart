import 'package:flutter/material.dart';

class CommentUi extends StatelessWidget {
  final String name;
  final String commentBody;
  CommentUi(this.name,this.commentBody);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width:double.infinity ,
      margin: EdgeInsets.all( 10),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.pink.withOpacity(0.2),

      ) ,
      child: Stack(
      children: [Align(alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(20),
        
        
        child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        ),),
      
      
      
      ),
      Align(alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical:40 ,horizontal:10 ),
        height: 30,
        width: double.infinity,
        
        child: Text(commentBody)),)
      
      
      ],
      
      
      
      ),





    );
  }
}