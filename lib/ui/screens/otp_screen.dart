import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/otp_timer.dart';
import 'otp_field_widget.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = "otpscreen";

  OtpScreen({super.key});

  final Map<String, TextEditingController> controllers = {
    'N1': TextEditingController(),
    'N2': TextEditingController(),
    'N3': TextEditingController(),
    'N4': TextEditingController(),
  };

  final Map<String, FocusNode> focusNodes = {
    'F1': FocusNode(),
    'F2': FocusNode(),
    'F3': FocusNode(),
    'F4': FocusNode(),
  };

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.isNotEmpty) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: ResponsiveHelper.getResponsiveHeight(5)),
            _buildTopImage(),
            SizedBox(height: ResponsiveHelper.getResponsiveHeight(5)),
            _buildMainContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopImage() {
    return Center(
      child: Image.asset(
        "assets/images/chracters.png",
        width: ResponsiveHelper.getResponsiveWidth(40),
        height: ResponsiveHelper.getResponsiveHeight(20),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildMainContainer() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: ResponsiveHelper.getResponsiveHeight(60),
        maxWidth: ResponsiveHelper.getResponsiveWidth(90),
      ),
      padding:
          ResponsiveHelper.getResponsivePadding(horizontal: 5, vertical: 5),
      decoration: const BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildVerificationText(),
          SizedBox(height: ResponsiveHelper.getResponsiveHeight(4)),
          _buildOtpFields(),
          SizedBox(height: ResponsiveHelper.getResponsiveHeight(2)),
          const TimerScreen(),
          SizedBox(height: ResponsiveHelper.getResponsiveHeight(2)),
          _buildWarningMessage(),
          SizedBox(height: ResponsiveHelper.getResponsiveHeight(4)),
          _buildButtons(),
          SizedBox(height: ResponsiveHelper.getResponsiveHeight(3)),
        ],
      ),
    );
  }

  Widget _buildVerificationText() {
    return Text(
      "We have sent a verification\ncode to the email\n\"A******@gmail.com\"",
      style: TextStyle(
        fontSize: ResponsiveHelper.fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OtpFieldWidget(
          controller: controllers['N1']!,
          currentFocus: focusNodes['F1']!,
          nextFocus: focusNodes['F2'],
          nextField: nextField,
          autofocus: true,
        ),
        OtpFieldWidget(
          controller: controllers['N2']!,
          currentFocus: focusNodes['F2']!,
          nextFocus: focusNodes['F3'],
          nextField: nextField,
        ),
        OtpFieldWidget(
          controller: controllers['N3']!,
          currentFocus: focusNodes['F3']!,
          nextFocus: focusNodes['F4'],
          nextField: nextField,
        ),
        OtpFieldWidget(
          controller: controllers['N4']!,
          currentFocus: focusNodes['F4']!,
          nextFocus: null,
          nextField: nextField,
        ),
      ],
    );
  }

  Widget _buildWarningMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/!.png",
          width: ResponsiveHelper.iconSize,
          height: ResponsiveHelper.iconSize,
        ),
        SizedBox(width: ResponsiveHelper.getResponsiveWidth(2)),
        Expanded(
          child: Text(
            "This is a temporary code, do not share it with anyone. Sharing the OTP with others can lead to significant security risks. The OTP is intended to be a private code.",
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(2),
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Container(
      width: ResponsiveHelper.buttonWidth,
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButtonColor,
              minimumSize: Size.fromHeight(ResponsiveHelper.buttonHeight),
            ),
            onPressed: () {
              // Handle reset password
            },
            child: Text(
              "Reset Password",
              style: TextStyle(
                fontSize: ResponsiveHelper.fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: ResponsiveHelper.getResponsiveHeight(2)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryButtonColor,
              minimumSize: Size.fromHeight(ResponsiveHelper.buttonHeight),
            ),
            onPressed: () {
              // Handle resend OTP
            },
            child: Text(
              "Resend OTP",
              style: TextStyle(
                fontSize: ResponsiveHelper.fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color backgroundColor = Color(0xFF1F3551);
  static const Color containerColor = Color(0xFF01122A);
  static const Color textColor = Color(0xFFA4A4A4);
  static const Color primaryButtonColor = Color(0xFF023A87);
  static const Color secondaryButtonColor = Color(0xFF808080);
}

class ResponsiveHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double fontSize;
  static late double iconSize;
  static late double buttonHeight;
  static late double buttonWidth;

  static bool isMobile = false;
  static bool isTablet = false;
  static bool isDesktop = false;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    if (screenWidth < 600) {
      isMobile = true;
      isTablet = false;
      isDesktop = false;
    } else if (screenWidth < 1200) {
      isMobile = false;
      isTablet = true;
      isDesktop = false;
    } else {
      isMobile = false;
      isTablet = false;
      isDesktop = true;
    }

    _initializeSizes();
  }

  static void _initializeSizes() {
    fontSize = isMobile
        ? blockSizeHorizontal * 4
        : isTablet
            ? blockSizeHorizontal * 3
            : blockSizeHorizontal * 2;

    iconSize = isMobile
        ? blockSizeHorizontal * 6
        : isTablet
            ? blockSizeHorizontal * 5
            : blockSizeHorizontal * 4;

    buttonHeight = isMobile
        ? blockSizeVertical * 7
        : isTablet
            ? blockSizeVertical * 6
            : blockSizeVertical * 5;

    buttonWidth = isMobile
        ? screenWidth * 0.85
        : isTablet
            ? screenWidth * 0.6
            : screenWidth * 0.4;
  }

  static double getResponsiveWidth(double percentage) {
    return screenWidth * (percentage / 100);
  }

  static double getResponsiveHeight(double percentage) {
    return screenHeight * (percentage / 100);
  }

  static double getResponsiveFontSize(double size) {
    double finalSize = size * blockSizeHorizontal;
    return finalSize.clamp(12, 32);
  }

  static EdgeInsets getResponsivePadding({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: getResponsiveWidth(horizontal),
      vertical: getResponsiveHeight(vertical),
    );
  }

  static double getResponsiveValue({
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
}
