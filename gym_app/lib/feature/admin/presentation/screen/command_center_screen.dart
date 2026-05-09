import 'package:flutter/material.dart';

class CommandCenterScreen extends StatelessWidget {
  const CommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Command Center')),
      body: const Center(
        child: Text('Manage your gym activities and products here.'),
      ),
    );
  }
}
