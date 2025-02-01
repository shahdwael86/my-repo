import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'on_boarding.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onvideo";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late List<VideoPlayerController> _videoControllers;
  late AnimationController _lockAnimationController;
  late Animation<double> _lockAnimation;
  bool _showLock = true;
  bool _showGetStarted = false;
  int _currentVideoIndex = 0;

  final List<String> videoAssets = [
    'assets/videos/1.mp4',
    'assets/videos/2.mp4',
    'assets/videos/3.mp4',
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideos();
    _initializeLockAnimation();
  }

  void _initializeVideos() {
    _videoControllers = videoAssets.map((asset) {
      return VideoPlayerController.asset(asset)
        ..initialize().then((_) {
          if (mounted) setState(() {});
        });
    }).toList();

    for (var i = 0; i < _videoControllers.length; i++) {
      _videoControllers[i].addListener(() {
        if (_videoControllers[i].value.position >=
            _videoControllers[i].value.duration) {
          _onVideoComplete(i);
        }
      });
    }
  }

  void _initializeLockAnimation() {
    _lockAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _lockAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _lockAnimationController,
      curve: Curves.easeOut,
    ));
  }

  void _onVideoComplete(int index) {
    if (index < _videoControllers.length - 1) {
      setState(() {
        _currentVideoIndex = index + 1;
        _videoControllers[_currentVideoIndex].play();
      });
    } else {
      setState(() {
        _showGetStarted = true;
      });
    }
  }

  void _onLockTap() {
    _lockAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLock = false;
        _videoControllers[0].play();
      });
    });
  }

  void _onGetStartedTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnBoarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Players
          ...List.generate(_videoControllers.length, (index) {
            return Opacity(
              opacity: _currentVideoIndex == index ? 1.0 : 0.0,
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoControllers[index].value.size.width ?? 0,
                    height: _videoControllers[index].value.size.height ?? 0,
                    child: VideoPlayer(_videoControllers[index]),
                  ),
                ),
              ),
            );
          }),

          // Lock Animation
          if (_showLock)
            Positioned(
              bottom: size.height * 0.1,
              left: 0,
              right: 0,
              child: Center(
                child: ScaleTransition(
                  scale: _lockAnimation,
                  child: GestureDetector(
                    onTap: _onLockTap,
                    child: Container(
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      constraints: const BoxConstraints(
                        maxWidth: 100,
                        maxHeight: 100,
                        minWidth: 60,
                        minHeight: 60,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: size.width * 0.08,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Progress Indicator
          if (!_showLock && !_showGetStarted)
            Positioned(
              bottom: size.height * 0.05,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _videoControllers.length,
                  (index) => Container(
                    width: size.width * 0.02,
                    height: size.width * 0.02,
                    constraints: const BoxConstraints(
                      maxWidth: 12,
                      maxHeight: 12,
                      minWidth: 8,
                      minHeight: 8,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentVideoIndex == index
                          ? const Color.fromARGB(255, 13, 51, 83)
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),

          // Get Started Button
          if (_showGetStarted)
            Positioned(
              bottom: size.height * 0.1,
              left: 0,
              right: 0,
              child: Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          width: size.width * 0.8,
                          constraints: const BoxConstraints(
                            maxWidth: 300,
                          ),
                          child: ElevatedButton(
                            onPressed: _onGetStartedTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.08,
                                vertical: size.height * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    _lockAnimationController.dispose();
    super.dispose();
  }
}
