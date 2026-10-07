class TokenStorage {
  // In a real app, you would save these in SharedPreferences or FlutterSecureStorage.
  // For demonstration and handcode clarity, we use static variables.
  static String? accessToken;
  static String? refreshToken;

  static void setTokens({required String access, required String refresh}) {
    accessToken = access;
    refreshToken = refresh;
  }

  static void clearTokens() {
    accessToken = null;
    refreshToken = null;
  }
}
