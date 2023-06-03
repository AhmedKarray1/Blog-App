import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/post.dart';
import 'package:test_technique1/Providers/posts_provider.dart';

class NewPost extends StatelessWidget {
 
  

  final _titlecontroller=TextEditingController();

  final _bodycontroller=TextEditingController();

  void _submitData(BuildContext context,int id){
    final enteredTitle=_titlecontroller.text;
    final enteredBody=_bodycontroller.text;
    if ((enteredTitle.isEmpty)||enteredBody.isEmpty)
    {return;}
    var newPost=Post(id:id,title: enteredTitle, body: enteredBody,comments: 
    []);
    Navigator.of(context).pop();

    Provider.of<postsProvider>(context,listen: false).createPost(newPost);





  }

  @override

  
  Widget build(BuildContext context) {
    final posts=Provider.of<postsProvider>(context);

    
    return SingleChildScrollView(
      child: Card(
        elevation: 16,
        child: Container(
          padding: EdgeInsets.only(top:10,right:10,left: 10,
          
          bottom: MediaQuery.of(context).viewInsets.bottom+10
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(decoration: InputDecoration(
              labelText:'title', ),
              controller: _titlecontroller,
              onSubmitted: (_)=>_submitData(context,posts.posts.length),




            ),
            TextField(decoration: InputDecoration(labelText:
            "body" 
            
            ),
            
            controller:_bodycontroller ,
            onSubmitted: (_)=>_submitData(context,posts.posts.length),
            
            ),
            ElevatedButton(onPressed: ()=>_submitData(context,posts.posts.length), 
            
            style: ButtonStyle(
              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink),
            )
            ,child: Text("submit")
            
            )




          ],
          
          
          
          
          ),




        ),



      ),






    );
  }
}