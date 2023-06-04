import 'package:flutter/material.dart';
import 'package:test_technique1/models/post.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return AnimatedOpacity(
                  opacity: _opacityAnimation.value,
                  duration: Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    height: height * _sizeAnimation.value,
                    width: width * _sizeAnimation.value,
                    duration: Duration(seconds: 1),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Icon(
                            Icons.article,
                            color: Colors.white,
                            size: height * 0.30,
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
                  margin: EdgeInsets.symmetric(
                      vertical: height * 0.1, horizontal: height * 0.05),
                  child: Text(
                    "Welcome to the Blog App",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
