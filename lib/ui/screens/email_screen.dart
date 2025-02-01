import 'package:flutter/material.dart';
import 'dart:math' show min;
import 'constants.dart';
import 'OTPscreen.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _moveAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _moveAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1, curve: Curves.easeIn),
      ),
    );
  }

  void _validateAndNavigate() {
    final String email = _emailController.text.trim();
    if (_isValidEmail(email)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Otp(email: email)),
      );
    } else {
      _showErrorSnackbar();
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter a valid email address'),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.1;
    const double maxWidth = 450.0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: maxWidth,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal,
                  vertical: size.height * 0.05,
                ),
                child: Column(
                  children: [
                    // Animated Image Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..translate(0.0, _moveAnimation.value)
                                ..scale(_scaleAnimation.value),
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryBlue
                                          .withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: Offset(
                                        0,
                                        5 + (_moveAnimation.value * 0.2),
                                      ),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/otp_image.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Text Container
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.03),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'OTP Verification',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: min(size.width * 0.06, 24),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'We will send you an One Time Password\non your email address',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white.withOpacity(0.7),
                                fontSize: min(size.width * 0.04, 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryBlue.withOpacity(0.3),
                              ),
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: min(size.width * 0.04, 16),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                  color: AppColors.white.withOpacity(0.5),
                                  fontSize: min(size.width * 0.04, 16),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05,
                                  vertical: 16,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                            ),
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _validateAndNavigate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Get OTP',
                                style: TextStyle(
                                  fontSize: min(size.width * 0.04, 16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Register Link Container
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Don't Have An Account? Register",
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.7),
                              fontSize: min(size.width * 0.035, 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
