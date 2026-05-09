import 'package:flutter/material.dart';

class ActivityDetailScreen extends StatelessWidget {
  const ActivityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Details')),
      body: const Center(
        child: Text('Detailed view of the selected activity.'),
      ),
    );
  }
}
