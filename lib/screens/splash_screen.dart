// // import 'package:flutter/material.dart';

// // class SplashScreen extends StatefulWidget {
  

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.pink,
// //       body: Center(
// //         child: Column(mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //           Container(
// //             height: MediaQuery.of(context).size.height*0.5,
// //             width: MediaQuery.of(context).size.width*0.5,
            
            
            
// //             child: Stack(children: [Positioned.fill(child: Icon(Icons.article,color: Colors.white,
// //             size: MediaQuery.of(context).size.height*0.30,))],)
            
// //             )






// //         ]),
// //       ),
      


// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//    AnimationController _animationController;
//    Animation<double> _sizeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(seconds: 5),
//       vsync: this,
//     );

//     _sizeAnimation = Tween<double>(begin: 0, end: 0.5).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (BuildContext context, Widget child) {
//                 return Container(
//                   height: MediaQuery.of(context).size.height *
//                       _sizeAnimation.value, // Animated height
//                   width: MediaQuery.of(context).size.width *
//                       _sizeAnimation.value, // Animated width
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: Icon(
//                           Icons.article,
//                           color: Colors.white,
//                           size: MediaQuery.of(context).size.height * 0.30,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
   AnimationController _animationController;
   Animation<double> _sizeAnimation;
   Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return AnimatedOpacity(
                  opacity: _opacityAnimation.value, // Animated opacity
                  duration: Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    height: MediaQuery.of(context).size.height *
                        _sizeAnimation.value, // Animated height
                    width: MediaQuery.of(context).size.width *
                        _sizeAnimation.value, // Animated width
                    duration: Duration(seconds: 1),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Icon(
                            Icons.article,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.30,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.1,horizontal: MediaQuery.of(context).size.height*0.05),
                
                
                child: Text("Welcome to the Blog App", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50),)),
            )
          ],
        ),
      ),
    );
  }
}

