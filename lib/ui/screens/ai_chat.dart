import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/home_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/map_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/notification_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/profile_screen.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';
import '../public_details/card_chat.dart';

class AiChat extends StatelessWidget {
  static const String routeName="ai chat";
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: AppColors.cardColor, //
       appBar: AppBar(
         backgroundColor: AppColors.cardColor,
         title: const Text(
           TextStrings.appBarAiChat,
           style: TextStyle(color: Colors.white),
         ),
         centerTitle: true,
         leading: IconButton(
           icon: const Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () {
             Navigator.pop(context);
           },
         ),
         //leading: const Icon(Icons.arrow_back, color: Colors.white),
         elevation: 0,
       ),
       body: Column(
         children: [
           const SizedBox(height: 92),
           Center(
             child: Image.asset(
               'assets/images/ai.png',
               width: 150,
               height: 150,
             ),
           ),
           const SizedBox(height: 88),

           const InfoCard(
             title: TextStrings.titleCard1,
             subtitle: TextStrings.subTitleCard1,
           ),
           const SizedBox(height: 20),
           const InfoCard(
             title: TextStrings.titleCard2,
             subtitle:TextStrings.subTitleCard2,
           ),

           const Spacer(),
           Padding(
             padding: const EdgeInsets.only(left: 25,right: 30,bottom: 20,top: 15),
             child: Row(
               children: [
                 Expanded(
                   child: TextField(
                     decoration: InputDecoration(
                       hintText: TextStrings.hintChatText,
                       filled: true,
                       fillColor: Colors.white,
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(15),
                         borderSide: BorderSide.none,
                       ),

                       suffixIcon: IconButton(
                         icon: const Icon(Icons.camera_alt_outlined, color: AppColors.basicButton),
                         onPressed: () {
                           print("Camera button pressed");
                         },
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(width: 15),
                 CircleAvatar(
                   backgroundColor: AppColors.aiElevatedButton,
                   radius: 25,
                   child: IconButton(
                     icon: const Icon(Icons.send, color: Colors.white),
                     onPressed: () {},
                   ),
                 ),
               ],
             ),
           ),
         ],
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
