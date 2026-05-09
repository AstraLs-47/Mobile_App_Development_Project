class RouteConstants {
  // Private constructor to prevent instantiation
  RouteConstants._();

  // User Routes
  static const String root = '/';
  static const String rootName = 'progress';

  static const String dashboard = '/dashboard';
  static const String dashboardName = 'dashboard';

  static const String exercises = '/exercises';
  static const String exercisesName = 'exercises';

  static const String products = '/products';
  static const String productsName = 'products';

  static const String profile = '/profile';
  static const String profileName = 'profile';

  // Admin Routes
  static const String admin = '/admin';
  static const String adminName = 'admin';

  static const String adminActivitiesRel = 'activities';
  static const String adminActivitiesName = 'adminActivities';

  static const String adminProductsRel = 'products';
  static const String adminProductsName = 'adminProducts';

  static const String adminAnnouncementsRel = 'announcements';
  static const String adminAnnouncementsName = 'adminAnnouncements';
}
