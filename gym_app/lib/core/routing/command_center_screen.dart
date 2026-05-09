import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_constants.dart';
import 'package:gym_app/feature/admin/presentation/widget/admin_bottom_nav.dart';

class CommandCenterScreen extends StatelessWidget {
  final Widget child;

  const CommandCenterScreen({
    super.key,
    required this.child,
  });

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/admin') return 0;
    if (location.startsWith('/admin/activities')) return 1;
    if (location.startsWith('/admin/products')) return 2;
    if (location.startsWith('/admin/announcements')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child, // This is where the specific admin page is rendered
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _calculateSelectedIndex(context),
      ),
    );
  }
}