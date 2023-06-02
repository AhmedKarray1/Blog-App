import 'package:flutter/material.dart';

class PostUi extends StatelessWidget {
  final String title;
  PostUi(this.title);
  

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
     
      width:MediaQuery.of(context).size.width*0.8,
      height: 100,
      decoration: BoxDecoration(
        
        color: Colors.pink.withOpacity(0.3),
        // borderRadius:BorderRadius.circular(20) 
        
        



      ) ,
      child: Stack(children: [

Align(alignment: Alignment.topRight,
child: GestureDetector(
  onTap: () {print("ahmed");},
  child:   Container(
  
    margin: EdgeInsets.only(right: 10,top: 10),
  
  
  
  
  
    height: 50,
  
    width: 50,
  
    decoration: BoxDecoration(
  
    shape: BoxShape.circle,
  
    color: Colors.pink
  
  
  
  
  
  
  
  
  
  ),
  
  child: Icon(Icons.delete,color: Colors.white,
  
  size: 35,
  
  ),
  
  
  
  
  
  ),
),),
Align(alignment: Alignment.center,

child: Text(this.title,style: TextStyle(fontSize: 30,
fontWeight:FontWeight.bold ,color: Colors.black),),

)


      ],),
      
      
      
      );


  
  }
}