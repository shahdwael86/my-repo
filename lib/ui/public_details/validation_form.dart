import 'package:flutter/material.dart';
//import 'package:road_helperr/provider/settings_provider.dart';
import 'package:road_helperr/ui/public_details/input_field.dart';
import 'package:road_helperr/ui/public_details/main_button.dart';
import 'package:road_helperr/ui/public_details/or_border.dart';
import 'package:road_helperr/ui/screens/otp_screen.dart';
import 'package:road_helperr/ui/screens/signin_screen.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';

class ValidationForm extends StatelessWidget {
  ValidationForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 300),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(
                icon: Icons.person,
                label: "First Name",
                hintText: 'First name',
                validatorIsContinue: (text) {
                  if (text.length < 10) {
                    return "At least 10 characters";
                  }
                  return null;
                },
              ),
              // const SizedBox(height: 1),
              InputField(
                icon: Icons.person,
                label: "Last Name",
                hintText: 'Last name',
                validatorIsContinue: (text) {
                  if (text.length < 10) {
                    return "At least 10 characters";
                  }
                  return null;
                },
              ),
              //const SizedBox(height: 1),
              InputField(
                  icon: Icons.phone,
                  label: "Phone Number",
                  hintText: 'phone',
                  validatorIsContinue: (phoneText) {
                    if (phoneText.length < 11) {
                      return "Must be 11 digits";
                    }
                    return null;
                  }),
              const SizedBox(height: 1),
              InputField(
                icon: Icons.email_outlined,
                label: "Email",
                hintText: 'email',
                validatorIsContinue: (emailText) {
                  final regExp = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (!regExp.hasMatch(emailText)) {
                    return "Email is not valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 1),
              InputField(
                icon: Icons.lock,
                label: "Password",
                hintText: 'password',
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
              const SizedBox(height: 1),
              InputField(
                icon: Icons.lock,
                label: "Confirm Password",
                hintText: 'confirm password',
                isPassword: true,
                validatorIsContinue: (confirmPasswordText) {
                  final regExpCon = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if (!regExpCon.hasMatch(confirmPasswordText)) {
                    return "must be identical to the password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              MainButton(
                  textButton: TextStrings.textButton,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtpScreen()),
                    );
                    if (_formKey.currentState!.validate()) {
                      print("Hello SignUp");
                    }
                  }),
              const SizedBox(height: 1),
              const OrBorder(),
              Padding(
                padding: const EdgeInsets.only(left: 88, right: 30),
                child: Row(
                  children: [
                    Text(
                      TextStrings.textToSignUp,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.borderField),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignInScreen.routeName);
                        },
                        child: Text(
                          TextStrings.logIn,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.signAndRegister),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
