import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:road_helperr/ui/screens/new_password_screen.dart';
import 'dart:async';
import 'constants.dart';

class Otp extends StatefulWidget {
  final String email;

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
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != AppConstants.otpLength) {
      setState(() => _errorMessage = 'Please enter complete OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Add your API call here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Example API call:
      // final response = await http.post(
      //   Uri.parse('your-api-endpoint'),
      //   body: {
      //     'email': widget.email,
      //     'otp': _otpController.text,
      //   },
      // );

      // For demo, we'll consider OTP "12345" as valid
      bool isValid = _otpController.text == "12345";

      if (isValid) {
        setState(() => _isVerified = true);
        _showSuccessDialog();
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NewPasswordScreen()), // غير HomeScreen للصفحة اللي انت عايزها
          );
        });
      } else {
        setState(() => _errorMessage = 'Invalid OTP. Please try again.');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Verification failed. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resendOtp() async {
    if (_timeLeft == 0) {
      // Add your resend OTP API call here
      setState(() {
        _timeLeft = AppConstants.otpTimeout;
        _errorMessage = null;
        _otpController.clear();
      });
      startTimer();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP resent successfully'),
          backgroundColor: AppColors.successGreen,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.successGreen,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verification Successful!',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Add navigation to next screen here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(size.width * 0.05),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isSmallScreen ? 20 : 40),
                        Image.asset(
                          'assets/otp_image.png',
                          height: size.height * 0.25,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: size.height * 0.04),
                        Text(
                          'OTP Verification',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Enter OTP sent to ${widget.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.7),
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                          ),
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
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: size.width * 0.13,
                              fieldWidth: size.width * 0.13,
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
                        if (_errorMessage != null)
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: AppColors.errorRed,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Time remaining: $timerText',
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.7),
                            fontSize: size.width * 0.035,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _verifyOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextButton(
                          onPressed: _timeLeft == 0 ? _resendOtp : null,
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: _timeLeft == 0
                                  ? AppColors.primaryBlue
                                  : AppColors.white.withOpacity(0.5),
                              fontSize: size.width * 0.04,
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
