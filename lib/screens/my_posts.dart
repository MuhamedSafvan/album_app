import 'package:album_app/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/dio_service.dart';
import 'post_detailed_view.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({
    super.key,
  });

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  void fetchData() async {
    await DioService().getPosts(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: Consumer<AppProvider>(builder: (context, model, _) {
        final posts = model.posts;
        return ListView.separated(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(posts[index].title ?? ''),
              subtitle: Text(posts[index].body ?? ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailScreen(post: posts[index]),
                  ),
                );
              },
            );
          }, separatorBuilder: (BuildContext context, int index) => Divider(),
        );
      }),
    );
  }
}
