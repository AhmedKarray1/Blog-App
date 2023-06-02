import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/posts.dart';
import 'package:test_technique1/screens/offline_post_list_screen.dart';
import 'package:test_technique1/screens/original_post_list_screen.dart';



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
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       
        appBar:AppBar(
          backgroundColor: Colors.pink,
          
          title: 
        
        
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.article),
          SizedBox(width: 20,),
            Text("Blog App"),
          ],
        ),
        bottom: TabBar(tabs: [Icon(Icons.wifi_off_sharp,color: Colors.white,size: 50,),
        Icon(Icons.wifi,color: Colors.white,size: 50,),]),
        
        
        ) ,
        body:_isLoading?Center(child: CircularProgressIndicator(),):
        TabBarView(children: [
          OfflinePostListScreen(),OriginalPostListScreen(),
        

          


        ])
          ),
    );
      
       






   
  }
}