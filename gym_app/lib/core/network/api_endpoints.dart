class ApiEndpoints {
  // Change to your local machine IP for Android emulator, or localhost for iOS/web
  static const String baseUrl = 'http://localhost:3000/api';

  // Auth
  static const String login = '$baseUrl/auth/signin';
  static const String register = '$baseUrl/auth/signup';
  static const String profile = '$baseUrl/auth/me';

  // Products
  static const String products = '$baseUrl/products';
  static String product(String id) => '$products/$id';

  // Exercises
  static const String exercises = '$baseUrl/exercises';
  static String exercise(String id) => '$exercises/$id';

  // Categories
  static const String categories = '$baseUrl/categories';
  static String category(String id) => '$categories/$id';

  // Announcements
  static const String announcements = '$baseUrl/announcements';
  static String announcement(String id) => '$announcements/$id';

  // Progress
  static const String progress = '$baseUrl/progress';
  static const String progressStats = '$baseUrl/progress/stats';
  static String progressEntry(String id) => '$progress/$id';

  // Health
  static const String health = '$baseUrl/health';
  static const String healthLatest = '$baseUrl/health/latest';
  static String healthEntry(String id) => '$health/$id';

  // Admin
  static const String adminDashboard = '$baseUrl/admin/dashboard';
  static const String adminUsersStats = '$baseUrl/admin/users/stats';
  static const String adminExercisesStats = '$baseUrl/admin/exercises/stats';
  static const String adminProgressStats = '$baseUrl/admin/progress/stats';
  static const String adminHealthStats = '$baseUrl/admin/health/stats';
  static const String adminProductsStats = '$baseUrl/admin/products/stats';
  static const String adminActivityLogs = '$baseUrl/admin/activity/logs';
  static const String adminActivityStats = '$baseUrl/admin/activity/stats';

  // User Profile
  static const String userProfile = '$baseUrl/user/profile';
  static const String userOnboard = '$baseUrl/user/onboard';
}