
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/profile_screen.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';

import '../ai_chat.dart';
import 'map_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Map<String, bool> serviceStates = {
    TextStrings.homeGas: false,
    TextStrings.homePolice: false,
    TextStrings.homeFire: false,
    TextStrings.homeHospital: false,
    TextStrings.homeMaintenance: false,
    TextStrings.homeWinch: false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home background.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.location_on_outlined, color: Colors.white),
            onPressed: () {
              // لما ندوس هنا ممكن نروح للخريطه او اي حته تانيه انا عايزاها
            },
          ),
          title: const Text(
            TextStrings.homeYourLocation,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/Ellipse 42.png'),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                TextStrings.homeGetYouBack,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          children: serviceStates.entries.map((entry) {
                            return ServiceCard(
                              title: entry.key,
                              icon: getServiceIcon(entry.key),
                              isSelected: entry.value,
                              onToggle: (value) {
                                setState(() {
                                  serviceStates[entry.key] = value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.basicButton,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 39,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                        },
                        child: const Text(
                          TextStrings.homeGetYourService,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }

  }

  IconData getServiceIcon(String title) {
    switch (title) {
      case TextStrings.homeGas:
        return Icons.local_gas_station;
      case TextStrings.homePolice:
        return Icons.local_police;
      case TextStrings.homeFire:
        return Icons.fire_truck;
      case TextStrings.homeHospital:
        return Icons.local_hospital;
      case TextStrings.homeMaintenance:
        return Icons.build;
      case TextStrings.homeWinch:
        return Icons.car_repair;
      default:
        return Icons.help;
    }
  }


class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool> onToggle;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.stackColorIsSelected : AppColors.stackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 13,
            right: 12,
            child: Switch(
              value: isSelected,
              onChanged: onToggle,
              activeColor: Colors.white,
              activeTrackColor:  AppColors.backGroundColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.switchColor,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 77, left: 5, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 50,
                    color: isSelected ? Colors.white : AppColors.backGroundColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    maxLines: 2,
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textStackColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
