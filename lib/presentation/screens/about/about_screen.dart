// lib/presentation/screens/about/about_screen.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/about_section.dart';

/// Standalone About screen that wraps the reusable AboutSection widget.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const SingleChildScrollView(
        child: AboutSection(),
      ),
    );
  }
}