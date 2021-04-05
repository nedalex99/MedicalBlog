import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Saved'),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }
}
