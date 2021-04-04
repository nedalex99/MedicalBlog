import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('aaa'),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: 0,
        ),
      ),
    );
  }
}
