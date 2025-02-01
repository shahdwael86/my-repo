import 'package:flutter/material.dart';
import 'package:road_helperr/ui/public_details/ai_button.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';

class AiWelcomeScreen extends StatelessWidget {
  static const String routeName="ai welcome";
  const AiWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.cardColor, // Dark blue background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    'assets/images/bot.png',
                    height: 366,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                TextStrings.text1Ai,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Subtitle text
              const Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  TextStrings.text2Ai,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 77),
              const AiButton(),

            ],
          ),
        ),
      ),
    );


  }
}
