import 'package:flutter/material.dart';
import 'package:road_helperr/ui/public_details/validation_form.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName="signupscreen";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 17,top: 18,bottom: 30),
              child: Container(
                 width: mediaQuery.width*100,
                 height:  mediaQuery.height*0.268,
              decoration: const BoxDecoration(
               color: Color(0xFF1F3551),
                  image:DecorationImage(
                    image: AssetImage("assets/images/rafiki.png",),
                    fit: BoxFit.fill,
                  ),

              ),
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 272),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft:Radius.circular(20),
                      topRight: Radius.circular(20),
                  ),
                  color:Theme.of(context).primaryColor,
                ),
                height: double.infinity,
                width: double.infinity,

              ),

            ),
            ValidationForm(),


          ],

        ),
    );

  }
}
