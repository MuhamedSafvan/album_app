import 'package:album_app/providers/app_provider.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../utils/urls.dart';

class DioService {
  late Dio dio;

  DioService() {
    dio = Dio(BaseOptions(
      baseUrl: Urls.baseUrl,
      headers: {},
      connectTimeout: Duration(milliseconds: 3000000),
      receiveTimeout: Duration(milliseconds: 1000000),
      followRedirects: true,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
      contentType: ResponseType.plain.toString(),
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        print(e);
        Response res = _handleDioError(e);
        handler.resolve(res);
      },
    ));
  }

  Response _handleDioError(DioError dioError) {
    String message;
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        switch (dioError.response!.statusCode) {
          case 400:
            message = 'Bad request';
            break;
          case 404:
            message = "404 bad request";
            break;
          case 422:
            message = "422 bad request";
            break;
          case 500:
            message = 'Internal server error';
            break;
          default:
            message = 'Oops something went wrong';
            break;
        }
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
    return Response(
        requestOptions: RequestOptions(path: ""),
        data: dioError.response?.data,
        statusMessage: message,
        statusCode: dioError.response?.statusCode ?? 500);
  }

  Future getUserData(context) async {
    final state = Provider.of<AppProvider>(context, listen: false);
    // dio.options.headers['Authorization'] = 'Bearer ${state.userModel.access}';
    dio.options.headers['content-Type'] = 'application/json';
    // final isCached = await apiCacheManager.isAPICacheKeyExist(userCache);
    // if (isCached) {
    //   return dio.get(Urls.profileUrl, queryParameters: {'id': 1});
    // } else {}
    final response = await dio.get(Urls.profileUrl, queryParameters: {'id': 1});
    state.getUserData(response.data);
  }

  Future getAlbums(context) async {
    final state = Provider.of<AppProvider>(context, listen: false);
    // dio.options.headers['Authorization'] = 'Bearer ${state.userModel.access}';
    dio.options.headers['content-Type'] = 'application/json';
    // final isCached = await apiCacheManager.isAPICacheKeyExist(userCache);
    // if (isCached) {
    //   return dio.get(Urls.profileUrl, queryParameters: {'id': 1});
    // } else {}
    final response =
        await dio.get(Urls.albumsUrl, queryParameters: {'userId': 1});
    state.getAlbumData(response.data);
  }

  Future getPhotos(context, int albumId) async {
    final state = Provider.of<AppProvider>(context, listen: false);
    // dio.options.headers['Authorization'] = 'Bearer ${state.userModel.access}';
    dio.options.headers['content-Type'] = 'application/json';
    // final isCached = await apiCacheManager.isAPICacheKeyExist(userCache);
    // if (isCached) {
    //   return dio.get(Urls.profileUrl, queryParameters: {'id': 1});
    // } else {}
    state.albumPhotos = [];
    final response =
        await dio.get(Urls.photosUrl, queryParameters: {'albumId': albumId});
    state.getAlbumPhotos(response.data);
  }

  Future getPosts(context) async {
    final state = Provider.of<AppProvider>(context, listen: false);
    // dio.options.headers['Authorization'] = 'Bearer ${state.userModel.access}';
    dio.options.headers['content-Type'] = 'application/json';
    // final isCached = await apiCacheManager.isAPICacheKeyExist(userCache);
    // if (isCached) {
    //   return dio.get(Urls.profileUrl, queryParameters: {'id': 1});
    // } else {}
    final response =
        await dio.get(Urls.postsUrl, queryParameters: {'userId': 1});
    state.getPosts(response.data);
  }


  Future getPostComments(context,int postId) async {
    final state = Provider.of<AppProvider>(context, listen: false);
    // dio.options.headers['Authorization'] = 'Bearer ${state.userModel.access}';
    dio.options.headers['content-Type'] = 'application/json';
    // final isCached = await apiCacheManager.isAPICacheKeyExist(userCache);
    // if (isCached) {
    //   return dio.get(Urls.profileUrl, queryParameters: {'id': 1});
    // } else {}
    state.comments = [];
    final response =
        await dio.get(Urls.commentsUrl, queryParameters: {'postId': postId});
    state.getPostComments(response.data);
  }
  
}
