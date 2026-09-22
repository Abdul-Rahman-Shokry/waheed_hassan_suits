import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_image.dart';

class MainLayoutView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayoutView({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: AppImage("inactive_home.svg"),
            activeIcon: AppImage("active_home.svg"),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: AppImage("inactive_box.svg"),
            activeIcon: AppImage("active_box.svg"),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: AppImage("inactive_cart.svg"),
            activeIcon: AppImage("active_cart.svg"),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: AppImage("inactive_profile.svg"),
            activeIcon: AppImage("active_profile.svg"),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
