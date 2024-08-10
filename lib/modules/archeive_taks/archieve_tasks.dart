import 'package:flutter/material.dart';

class ArcheiveTasks extends StatelessWidget {
  const ArcheiveTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Arcieve',
            ),
          ],
        ),
      ),
    );
  }
}
