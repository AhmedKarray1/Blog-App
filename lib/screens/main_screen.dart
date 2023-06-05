import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_technique1/Providers/posts_provider.dart';
import 'package:test_technique1/screens/offline_post_list_screen.dart';
import 'package:test_technique1/screens/original_post_list_screen.dart';
import 'package:test_technique1/screens/splash_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      var postsprovider = Provider.of<PostsProvider>(context);

      await postsprovider.loadData();
      await postsprovider.checkConnectivity();

      if ((postsprovider.connectivityResult == ConnectivityResult.wifi) ||
          (postsprovider.connectivityResult == ConnectivityResult.mobile)) {
        Provider.of<PostsProvider>(context, listen: false)
            .fetchPosts()
            .then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final savedposts = Provider.of<PostsProvider>(context).local_saved_posts;

    return _isLoading
        ? SplashScreen()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.pink,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Blog App",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  bottom: TabBar(tabs: [
                    Icon(
                      Icons.wifi,
                      color: Colors.white,
                      size: 40,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.wifi_off_sharp,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(savedposts.length.toString())
                      ],
                    ),
                  ]),
                ),
                body: TabBarView(children: [
                  OriginalPostListScreen(),
                  OfflinePostListScreen(),
                ])),
          );
  }
}
