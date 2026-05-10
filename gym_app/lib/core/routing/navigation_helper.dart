import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_constants.dart';

enum BottomNavItem { dashboard, tracking, exercises, products, profile }

class NavigationHelper {
  NavigationHelper._();

  static const Map<BottomNavItem, String> bottomNavRoutes = {
    BottomNavItem.dashboard: RouteConstants.dashboardName,
    BottomNavItem.tracking: RouteConstants.trackingName,
    BottomNavItem.exercises: RouteConstants.exercisesName,
    BottomNavItem.products: RouteConstants.productsName,
    BottomNavItem.profile: RouteConstants.profileName,
  };

  static void onBottomNavTapped(
    BuildContext context,
    BottomNavItem item,
    BottomNavItem current,
  ) {
    if (item == current) return;

    final route = bottomNavRoutes[item];
    if (route != null) {
      context.goNamed(route);
    }
  }
}
