// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

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
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Daily Progress Tracking Screen')),
        ),
      ),
      GoRoute(
        path: RouteConstants.dashboard,
        name: RouteConstants.dashboardName,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Dashboard'))),
      ),
      GoRoute(
        path: RouteConstants.exercises,
        name: RouteConstants.exercisesName,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Exercises'))),
      ),
      GoRoute(
        path: RouteConstants.products,
        name: RouteConstants.productsName,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Products'))),
      ),
      GoRoute(
        path: RouteConstants.profile,
        name: RouteConstants.profileName,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Profile'))),
      ),
      // Note: Admin routes will be added here once screens are implemented
    ],
  );
}
