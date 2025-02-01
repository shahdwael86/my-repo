import 'package:flutter/material.dart';
import 'package:road_helperr/ui/public_details/input_field.dart';
import 'package:road_helperr/ui/public_details/main_button.dart';
import 'package:road_helperr/ui/public_details/or_border.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/home_screen.dart';
import 'package:road_helperr/ui/screens/email_screen.dart';
import 'package:road_helperr/ui/screens/signupScreen.dart';
import 'package:road_helperr/utils/text_strings.dart';

import '../../utils/app_colors.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "signipscreen";
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool status = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 17, top: 18, bottom: 30),
            child: Container(
              width: mediaQuery.width * 100,
              height: mediaQuery.height * 0.268,
              decoration: const BoxDecoration(
                color: Color(0xFF1F3551),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/rafiki.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 320),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).primaryColor,
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Text(TextStrings.welcomeText),
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child: Container(
              //color: Colors.amberAccent,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 80, left: 20, bottom: 15, top: 0.6),
                        child: Text(
                          TextStrings.welcomeText,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      InputField(
                        icon: Icons.email_outlined,
                        hintText: "email",
                        label: "Email",
                        validatorIsContinue: (emailText) {
                          final regExp = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!regExp.hasMatch(emailText)) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                      ),
                      InputField(
                        icon: Icons.lock,
                        hintText: "password",
                        label: "Password",
                        isPassword: true,
                        validatorIsContinue: (confirmPasswordText) {
                          final regExpCon = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (!regExpCon.hasMatch(confirmPasswordText)) {
                            return "Password Must be at least 8 characters in length "
                                "should contain at least one Special character"
                                "should contain at least one digit"
                                "should contain at least one lower case"
                                "should contain at least one upper case";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: status,
                                onChanged: (value) {
                                  setState(() {
                                    status = value!;
                                  });
                                },
                                checkColor: AppColors.cardColor,
                                fillColor: WidgetStatePropertyAll(Colors.white),
                              ),
                              Text(
                                TextStrings.rememberMessage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmailScreen()),
                                  );
                                },
                                child: Text(
                                  TextStrings.forgotMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: MainButton(
                            textButton: TextStrings.textButton2,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                              if (_formKey.currentState!.validate()) {
                                print("Hello LogIn");
                              }
                            }),
                      ),
                      const OrBorder(),
                      Padding(
                        padding: const EdgeInsets.only(left: 88, right: 30),
                        child: Row(
                          children: [
                            Text(
                              TextStrings.textToSignIn,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColors.borderField),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(SignupScreen.routeName);
                                },
                                child: Text(
                                  TextStrings.register,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.signAndRegister),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
