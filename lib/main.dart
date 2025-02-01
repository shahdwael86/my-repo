import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/ai_chat.dart';
import 'package:road_helperr/ui/screens/ai_welcome_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/home_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/map_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/notification_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/profile_screen.dart';
import 'package:road_helperr/ui/screens/edit_profile_screen.dart';
import 'package:road_helperr/ui/screens/on_boarding.dart';
import 'package:road_helperr/ui/screens/onboarding.dart';
import 'package:road_helperr/ui/screens/otp_expired_screen.dart';
import 'package:road_helperr/ui/screens/otp_screen.dart';
import 'package:road_helperr/ui/screens/profile_screen.dart';
import 'package:road_helperr/ui/screens/signin_screen.dart';
import 'package:road_helperr/ui/screens/signupScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get email => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1F3551),
        cardTheme: CardTheme(
          color: const Color(0xFF01122A),
          surfaceTintColor: const Color(0xFF01122A),
          elevation: 18,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1F3551),
          primary: Color(0xFF01122A),
          secondary: Color(0xFF023A87),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
      ),
      routes: {
        SignupScreen.routeName: (context) => SignupScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        AiWelcomeScreen.routeName: (context) => AiWelcomeScreen(),
        AiChat.routeName: (context) => AiChat(),
        HomeScreen.routeName: (context) => HomeScreen(),
        MapScreen.routeName: (context) => MapScreen(),
        NotificationScreen.routeName: (context) => NotificationScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        OtpScreen.routeName: (context) => OtpScreen(),
        OnBoarding.routeName: (context) => OnBoarding(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        OtpExpiredScreen.routeName: (context) => OtpExpiredScreen(),
        PersonScreen.routeName: (context) => PersonScreen(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),
      },

      initialRoute: OnboardingScreen.routeName,
      //initialRoute: AiWelcomeScreen.routeName,
      //initialRoute: SignupScreen.routeName,
    );
  }
}
