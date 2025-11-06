class ApiConfig {
  //static const String baseUrl = "http://192.168.100.9:3001";
  static const String baseUrl = "https://sututeh-server.onrender.com";

  
  // Endpoints
  static const String loginMobile = "$baseUrl/api/auth/mobile/login";
  static const String logoutMobile = "$baseUrl/api/auth/mobile/logout";
  static const String verifyToken = "$baseUrl/api/auth/mobile/verify";
  static const String verifyGoogleEmail = "$baseUrl/api/auth/mobile/verify-google-email"; // ← NUEVO
}