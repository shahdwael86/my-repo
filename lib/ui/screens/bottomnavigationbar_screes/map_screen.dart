import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/profile_screen.dart';

import '../../../utils/app_colors.dart';
import '../ai_chat.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class MapScreen extends StatelessWidget {
  static const String routeName = "map";
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('map screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.yellow,
      body: Center(child: Text('Welcome to map screen')),
    bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: AppColors.cardColor,
    color: AppColors.backGroundColor ,
    animationDuration: const Duration(milliseconds: 300),
    height: 56,
    index: _selectedIndex,
    items: const [
    Icon(Icons.home_outlined, size: 20, color: Colors.white),
    Icon(Icons.location_on_outlined, size: 20, color: Colors.white),
    Icon(Icons.textsms_outlined, size: 20, color: Colors.white),
    Icon(Icons.notifications_outlined, size: 20, color: Colors.white),
    Icon(Icons.person_2_outlined, size: 20, color: Colors.white),
    ],
    onTap: (index) {

    switch (index) {
    case 0:
    Navigator.pushNamed(context, HomeScreen.routeName);
    break;
    case 1:
    Navigator.pushNamed(context, MapScreen.routeName);
    break;
    case 2:
    Navigator.pushNamed(context, AiChat.routeName);
    break;
    case 3:
    Navigator.pushNamed(context, NotificationScreen.routeName);
    break;
    case 4:
    Navigator.pushNamed(context, ProfileScreen.routeName);
    break;
    }
    },
    ),
    );
  }
}