import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/comments.dart';
import 'package:test_technique1/Providers/posts.dart';
import 'package:test_technique1/screens/main_screen.dart';

void main()
{
runApp(MyApp());

}
class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return  
    MultiProvider(providers: [ChangeNotifierProvider(create: (ctx)=>Comments()),
    ChangeNotifierProvider(create: (ctx)=>Posts())]
    ,child: MaterialApp(title: "App",
    home: MainScreen(),)
    
    
    
    
    

    )

    ;
  }
}
