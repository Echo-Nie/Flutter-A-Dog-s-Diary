import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/function_buttons.dart';
import '../widgets/tab_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: const [
            ProfileHeader(),
            FunctionButtons(),
            Expanded(child: TabSection()),
          ],
        ),
      ),
    );
  }
} 