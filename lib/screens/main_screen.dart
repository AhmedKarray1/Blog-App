import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/posts.dart';
import 'package:test_technique1/widgets/create_post.dart';
import 'package:test_technique1/widgets/post_ui.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 var _isInit=true;
 var _isLoading=false;
 
 
 @override
  void didChangeDependencies() {
    if(_isInit)
    {setState(() {
      _isLoading=true;
    });
Provider.of<Posts>(context).fetchPosts().then((value) {
  setState(() {
    _isLoading=false;
  });
});

    }

    _isInit=false;
    
    super.didChangeDependencies();
  }

  
  
  

  @override
  Widget build(BuildContext context) {
    final loadedPosts=Provider.of<Posts>(context);
    loadedPosts.fetchPosts();
    
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.pink,
        
        title: 
      
      
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.article),
        SizedBox(width: 20,),
          Text("Blog App"),
        ],
      ),
      
      
      ) ,
      body:_isLoading?Center(child: CircularProgressIndicator(),):
      Column(children: [
        Row(children: [
        Icon(Icons.wifi,color: Colors.black,size: 30,),SizedBox(width: 20,),
        Icon(Icons.delete,color: Colors.black,size: 30,)


      ],),
        CreatePost(),
        Container(height: 360,
        width: double.infinity,

        child: 
        ListView.builder(itemBuilder:((context, index) => PostUi("Post ${index+1}")) ,itemCount:loadedPosts.posts.length ,),
        )]));
      
       






   
  }
}