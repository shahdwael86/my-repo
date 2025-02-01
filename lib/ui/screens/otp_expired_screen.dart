import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: OtpExpiredScreen(),
//   ));
// }

class OtpExpiredScreen extends StatefulWidget {
  static const String routeName = "otpexpired";
  const OtpExpiredScreen({super.key});

  @override
  State<OtpExpiredScreen> createState() => _OtpExpiredScreenState();
}

class _OtpExpiredScreenState extends State<OtpExpiredScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 18, 42, 1),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                          size: constraints.maxWidth * 0.15,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.03),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'The OTP has expired!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Add your request OTP logic here
                            },
                            child: Text(
                              'Request OTP',
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: TextButton(
                          onPressed: () {
                            // Add your back to login logic here
                          },
                          child: Text(
                            'Back to Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: constraints.maxWidth * 0.04,
                            ),
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
    );
  }
}
