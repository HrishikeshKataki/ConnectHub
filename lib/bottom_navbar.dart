import 'package:connecthub/auth/freelancer/authentication.dart';
import 'package:connecthub/pages/profile_edit/freelancer_profile.dart';
import 'package:connecthub/pages/home/home.dart';
import 'package:connecthub/pages/orders/orders_page.dart';
import 'package:connecthub/pages/search_screen.dart';
import 'package:connecthub/pages/settings/settings_page.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';



class BottomNavBar extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  BottomNavBar({super.key});

  List<Widget> _buildScreens() {
  final AuthService _authService = AuthService();
  final User? user = _authService.getCurrentUser();
  String userId = '';
  if (user != null) {
    userId = user.uid;
  }
    return [
      const home(),
      OrdersPage(),
      const Search(),
      FreelancerProfile(freelancerId: userId,account: true,),
      const SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: white,
        inactiveColorPrimary: bg,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.checklist_outlined),
        title: "Orders",
        activeColorPrimary: white,
        inactiveColorPrimary: bg,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: "Search",
        activeColorPrimary: white,
        inactiveColorPrimary: bg,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle),
        title: "Account",
        activeColorPrimary: white,
        inactiveColorPrimary: bg,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: white,
        inactiveColorPrimary: bg,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarItems(),
            confineInSafeArea: true,
            backgroundColor: primary,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarStyle: NavBarStyle.style1,
          ),
        ),
      ),
    );
  }
}
