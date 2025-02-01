import 'package:flutter/material.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';
import 'package:road_helperr/ui/screens/ai_chat.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';

class AiButton extends StatelessWidget {
  const AiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientSlideToAct(
      text: TextStrings.getStarted,
      //sliderButtonIcon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
      sliderButtonIcon: Icons.insert_comment_sharp,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      backgroundColor: AppColors.aiElevatedButton2,

      onSubmit: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AiChat()),
        );
        debugPrint("Submitted!");
      },
      gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.blue,
            AppColors.aiElevatedButton,
            AppColors.aiElevatedButton
          ]),
    );
  }
}
