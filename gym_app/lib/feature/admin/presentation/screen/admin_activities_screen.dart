import 'package:flutter/material.dart';

class AdminActivitiesScreen extends StatelessWidget {
  const AdminActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Activities')),
      body: const Center(child: Text('List of Gym Activities')),
    );
  }
}
