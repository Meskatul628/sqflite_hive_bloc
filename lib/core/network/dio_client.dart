import 'package:dio/dio.dart';
import 'token_storage.dart';

class DioClient {
  late final Dio dio;
  late final Dio _tokenDio; // Separate Dio instance for refreshing token to avoid infinite interceptor loops

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://206.162.244.134:9680/api/v1/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Separate instance for refresh token request to prevent interceptor recursion
    _tokenDio = Dio(
      BaseOptions(
        baseUrl: 'http://206.162.244.134:9680/api/v1/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 1. Every request-er sathe access token header-e add kora
          if (TokenStorage.accessToken != null) {
            options.headers['Authorization'] = 'Bearer ${TokenStorage.accessToken}';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // 2. Jodi 401 Unauthorized ashe (mane access token expire hoye geche)
          if (error.response?.statusCode == 401) {
            try {
              // 3. Refresh token API call kore notun access token ana
              bool refreshed = await _refreshToken();

              if (refreshed) {
                // 4. Notun access token diye purono failed request er header update kora
                error.requestOptions.headers['Authorization'] = 'Bearer ${TokenStorage.accessToken}';

                // 5. Request ti abar retry/send kora
                final response = await dio.fetch(error.requestOptions);
                return handler.resolve(response);
              } else {
                // Refresh token o invalid/expire hole token clear kore login-e pathano
                TokenStorage.clearTokens();
                // TODO: Navigate to login screen here if needed
              }
            } catch (e) {
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      if (TokenStorage.refreshToken == null) return false;

      // Refresh token API endpoint (Tomar backend er endpoint onujayi eta change korbe)
      final response = await _tokenDio.post(
        'auth/refresh-token', 
        data: {
          'refreshToken': TokenStorage.refreshToken,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        // Backend response structure onujayi token extract kora
        final newAccessToken = data['data']['accessToken']; 
        final newRefreshToken = data['data']['refreshToken'];

        TokenStorage.setTokens(
          access: newAccessToken,
          refresh: newRefreshToken ?? TokenStorage.refreshToken!,
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
