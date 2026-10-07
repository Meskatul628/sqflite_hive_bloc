import 'package:bloc_test_demo/core/network/token_storage.dart';
import 'package:dio/dio.dart';

class DioClient2nd {
  late final Dio dio ;
  late final Dio dioToken ;

  DioClient2nd(){
     dio = Dio(
       BaseOptions(
         baseUrl: 'http://206.162.244.134:9680/api/v1/',
         connectTimeout: const Duration(seconds: 15),
         receiveTimeout: const Duration(seconds: 15),

       )
     );

     dioToken = Dio(
       BaseOptions(
         baseUrl: 'http://206.162.244.134:9680/api/v1/',
         connectTimeout: const Duration(seconds: 15),
         receiveTimeout: const Duration(seconds: 15),

       )
     );

     dio.interceptors.add(
       InterceptorsWrapper(
         onRequest: (options,handler){
           if(TokenStorage.accessToken != null){
             options.headers['Authorization'] = 'Bearer ${TokenStorage.accessToken}';
           }
           return handler.next(options);
         },
         onError: (DioException error,handler)async{
           if(error.response?.statusCode == 401){
             try{
               bool refreshed = await _refreshToken();
               if(refreshed) {
                 error.requestOptions.headers['Authorization'] =
                 'Bearer ${TokenStorage.accessToken}';
                 final response = await dio.fetch(error.requestOptions);
                 return handler.resolve(response);
               }
               else{
                 TokenStorage.clearTokens();
               }
             }catch(e){
               return handler.next(error);

             }
           }
         }
       )
     );
  }
  Future<bool> _refreshToken()async{
    try{
      if(TokenStorage.refreshToken == null) return false;
      final response = await dioToken.post(
          'auth/refresh-token',
          data: {
            'refreshToken': TokenStorage.refreshToken,
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        final data = response.data;
        final newAccessToken = data['data']['accessToken'];
        final newRefreshToken = data['data']['refreshToken'];
      }else{
        return false;
      }
      return true;
    }catch(e){
      return false;
    }
  }


}