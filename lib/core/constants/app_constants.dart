class AppConstants {
  static const String appName = 'SmartFab Industries';
  static const String appVersion = '1.0.0';
  
  // API Constants
  static const String baseUrl = 'https://api.smartfab.com';
  static const int apiTimeout = 30000; // 30 seconds
  
  // Database Constants
  static const String dbName = 'smartfab.db';
  static const int dbVersion = 1;
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Date Formats
  static const String defaultDateFormat = 'yyyy-MM-dd';
  static const String defaultDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
} 