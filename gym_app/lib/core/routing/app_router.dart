// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Admin Screen imports:
import 'package:gym_app/feature/admin/presentation/screen/admin_activities_screen.dart';
import 'package:gym_app/feature/admin/presentation/screen/admin_announcements_screen.dart';
import 'package:gym_app/feature/admin/presentation/screen/admin_products_screen.dart';
import 'package:gym_app/core/routing/command_center_screen.dart';
import 'package:gym_app/presentation/screen/daily_progress_tracking_screen.dart';
import 'package:gym_app/presentation/screen/dashboard_screen.dart';
import 'package:gym_app/presentation/screen/exercises_screen.dart';
import 'package:gym_app/presentation/screen/products_screen.dart';
import 'package:gym_app/presentation/screen/profile_screen.dart';

// Project imports:
import 'route_constants.dart';

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteConstants.root,
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
    routes: [
      // Main User Progress Route
      GoRoute(
        path: RouteConstants.root,
        name: RouteConstants.rootName,
        builder: (context, state) => const DailyProgressTrackingScreen(),
      ),
      GoRoute(
        path: RouteConstants.dashboard,
        name: RouteConstants.dashboardName,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteConstants.exercises,
        name: RouteConstants.exercisesName,
        builder: (context, state) => const ExercisesScreen(),
      ),
      GoRoute(
        path: RouteConstants.products,
        name: RouteConstants.productsName,
        builder: (context, state) => const ProductsScreen(),
      ),
      GoRoute(
        path: RouteConstants.profile,
        name: RouteConstants.profileName,
        builder: (context, state) => const ProfileScreen(),
      ),
      // Admin Routes
      GoRoute(
        path: RouteConstants.admin,
        name: RouteConstants.adminName,
        builder: (context, state) => const CommandCenterScreen(),
        routes: [
          GoRoute(
            path: RouteConstants.adminActivitiesRel,
            name: RouteConstants.adminActivitiesName,
            builder: (context, state) => const AdminActivitiesScreen(),
          ),
          GoRoute(
            path: RouteConstants.adminProductsRel,
            name: RouteConstants.adminProductsName,
            builder: (context, state) => const AdminProductsScreen(),
          ),
          GoRoute(
            path: RouteConstants.adminAnnouncementsRel,
            name: RouteConstants.adminAnnouncementsName,
            builder: (context, state) => const AdminAnnouncementsScreen(),
          ),
        ],
      ),
    ],
  );
}
