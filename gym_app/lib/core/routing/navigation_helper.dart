// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'route_constants.dart';

enum BottomNavItem { dashboard, tracking, exercises, products, profile }

/// A helper extension to centralize navigation logic using [GoRouter].
/// This provides a clean API for navigation and reduces boilerplate in widgets.
extension NavigationHelper on BuildContext {
  // User Routes
  void goProgress() => go(RouteConstants.root);

  // Admin Routes (Placeholders for future use)
  void goAdmin() => goNamed(RouteConstants.adminName);
  void pushAdminActivities() => pushNamed(RouteConstants.adminActivitiesName);
  void pushAdminProducts() => pushNamed(RouteConstants.adminProductsName);
  void pushAdminAnnouncements() =>
      pushNamed(RouteConstants.adminAnnouncementsName);

  // Common Navigation Actions
  void pop() {
    if (canPop()) {
      GoRouter.of(this).pop();
    }
  }

  // Bottom Navigation Logic
  void onBottomNavTapped(BottomNavItem item, BottomNavItem currentItem) {
    if (item == currentItem) return;

    switch (item) {
      case BottomNavItem.dashboard:
        goNamed(RouteConstants.dashboardName);
      case BottomNavItem.tracking:
        goNamed(RouteConstants.rootName);
      case BottomNavItem.exercises:
        goNamed(RouteConstants.exercisesName);
      case BottomNavItem.products:
        goNamed(RouteConstants.productsName);
      case BottomNavItem.profile:
        goNamed(RouteConstants.profileName);
    }
  }

  void pushWithData(String name, {Object? extra}) =>
      pushNamed(name, extra: extra);
}
