import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/profile_screen.dart';
import 'package:road_helperr/utils/text_strings.dart';

import '../../../utils/app_colors.dart';
import '../ai_chat.dart';
import 'home_screen.dart';
import 'map_screen.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = "notification";
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        backgroundColor:AppColors.cardColor,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        title: const Text(
          TextStrings.notify,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              TextStrings.clear,
              style: TextStyle(
                color: AppColors.switchColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image:AssetImage("assets/images/Group 12.png")),
            SizedBox(height: 20),
            Text(
              TextStrings.noNotify,
              style: TextStyle(
                color: AppColors.switchColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              TextStrings.notifyInbox,
              style: TextStyle(
                color: AppColors.switchColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),

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
    //بفتح الاسكرين حسب ما هضغط ع اي زرار
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