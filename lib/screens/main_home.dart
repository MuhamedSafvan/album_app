import 'package:album_app/screens/home_screen.dart';
import 'package:album_app/screens/my_albums.dart';
import 'package:album_app/screens/my_posts.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _screens = [
    HomeScreen(),
    MyAlbums(),
    MyPosts(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(controller: _tabController, children: _screens),
      ),
      bottomNavigationBar: TabBar(controller: _tabController, tabs: [
        Tab(
          text: 'Home',
          icon: Icon(
            Icons.home,
            color: Colors.indigo.shade500,
          ),
        ),
        Tab(
            text: 'My Albums',
            icon: Icon(
              Icons.photo,
              color: Colors.indigo.shade500,
            )),
        Tab(
            text: 'My Posts',
            icon: Icon(
              Icons.feed,
              color: Colors.indigo.shade500,
            )),
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}
