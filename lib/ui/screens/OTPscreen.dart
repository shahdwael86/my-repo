import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:road_helperr/ui/screens/signupScreen.dart';
import 'dart:async';
import 'constants.dart';

class Otp extends StatefulWidget {
  final String email;
  static const String routeName = "otpscreen";

  const Otp({super.key, required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<Otp> with SingleTickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;
  int _timeLeft = AppConstants.otpTimeout;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    startTimer();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOtp() async {
    // منطق التحقق من OTP
  }

  Future<void> _resendOtp() async {
    // منطق إعادة إرسال OTP
  }

  void _showSuccessDialog() {
    // منطق عرض رسالة النجاح
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final platform = Theme.of(context).platform;
    final isIOS =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: responsive.getPadding(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: responsive.maxContentWidth,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: responsive.spacing),
                        Image.asset(
                          'assets/otp_image.png',
                          height: responsive.imageHeight,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: responsive.spacing),
                        Text(
                          'OTP Verification',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: responsive.titleSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: isIOS ? '.SF Pro Text' : null,
                          ),
                        ),
                        SizedBox(height: responsive.smallSpacing),
                        Text(
                          'Enter OTP sent to ${widget.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.7),
                            fontSize: responsive.subtitleSize,
                            fontFamily: isIOS ? '.SF Pro Text' : null,
                          ),
                        ),
                        SizedBox(height: responsive.spacing),
                        Padding(
                          padding: responsive.getPadding(),
                          child: PinCodeTextField(
                            appContext: context,
                            length: AppConstants.otpLength,
                            controller: _otpController,
                            onChanged: (_) =>
                                setState(() => _errorMessage = null),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius:
                                  BorderRadius.circular(isIOS ? 8 : 10),
                              fieldHeight: responsive.otpFieldSize,
                              fieldWidth: responsive.otpFieldSize,
                              activeFillColor: AppColors.white,
                              inactiveFillColor:
                                  AppColors.white.withOpacity(0.8),
                              selectedFillColor: AppColors.white,
                              errorBorderColor: AppColors.errorRed,
                            ),
                            enableActiveFill: true,
                            errorAnimationController: null,
                          ),
                        ),
                        SizedBox(height: responsive.spacing),
                        ElevatedButton(
                          onPressed: _verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                          ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: responsive.subtitleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: responsive.spacing),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignupScreen.routeName);
                          },
                          child: const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

// Helper class للتعامل مع الأحجام المختلفة
class ResponsiveHelper {
  final BuildContext context;
  final Size size;
  final bool isTablet;
  final bool isDesktop;

  ResponsiveHelper(this.context)
      : size = MediaQuery.of(context).size,
        isTablet = MediaQuery.of(context).size.width > 600,
        isDesktop = MediaQuery.of(context).size.width > 1200;

  double get spacing => size.height * 0.04;
  double get smallSpacing => size.height * 0.02;
  double get titleSize =>
      size.width *
      (isDesktop
          ? 0.025
          : isTablet
              ? 0.035
              : 0.06);
  double get subtitleSize =>
      size.width *
      (isDesktop
          ? 0.018
          : isTablet
              ? 0.025
              : 0.04);
  double get imageHeight =>
      size.height *
      (isDesktop
          ? 0.2
          : isTablet
              ? 0.25
              : 0.25);
  double get otpFieldSize =>
      size.width *
      (isDesktop
          ? 0.08
          : isTablet
              ? 0.1
              : 0.13);
  double get maxContentWidth => isDesktop
      ? 800
      : isTablet
          ? 600
          : size.width;

  EdgeInsets getPadding() {
    return EdgeInsets.all(
      size.width *
          (isDesktop
              ? 0.03
              : isTablet
                  ? 0.04
                  : 0.05),
    );
  }
}
