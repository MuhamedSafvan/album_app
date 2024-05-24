import 'dart:convert';

import 'package:album_app/models/album_model.dart';
import 'package:album_app/models/photo_model.dart';
import 'package:flutter/material.dart';

import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class AppProvider extends ChangeNotifier {
  UserModel? userModel;
  List<AlbumModel> albums = [];
  List<PhotoModel> albumPhotos = [];
  List<PostModel> posts = [];
  List<CommentModel> comments = [];

  void getUserData(var response) {
    if (response != null) {
      final userListJson = response.map((e) => UserModel.fromJson(e)).toList();
      final userList = List<UserModel>.from(userListJson);
      if (userList.isNotEmpty) userModel = userList.first;
    }
    notifyListeners();
  }

  void getAlbumData(var response) {
    if (response != null) {
      final albumListJson =
          response.map((e) => AlbumModel.fromJson(e)).toList();
      final albumList = List<AlbumModel>.from(albumListJson);
      if (albumList.isNotEmpty) albums = albumList;
    }
    notifyListeners();
  }

  void getAlbumPhotos(var response) {
    if (response != null) {
      final photoListJson =
          response.map((e) => PhotoModel.fromJson(e)).toList();
      final photoList = List<PhotoModel>.from(photoListJson);
      if (photoList.isNotEmpty) albumPhotos = photoList;
    }
    notifyListeners();
  }

  void getPosts(var response) {
    if (response != null) {
      print(response);
      final postListJson = response.map((e) => PostModel.fromJson(e)).toList();
      final postList = List<PostModel>.from(postListJson);
      if (postList.isNotEmpty) posts = postList;
    }
    notifyListeners();
  }

  void getPostComments(var response) {
    if (response != null) {
      final commentListJson =
          response.map((e) => CommentModel.fromJson(e)).toList();
      final postCommentList = List<CommentModel>.from(commentListJson);
      if (postCommentList.isNotEmpty) comments = postCommentList;
    }
    notifyListeners();
  }
}
