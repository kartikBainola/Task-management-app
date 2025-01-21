import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screens/initScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: LottieBuilder.asset("assets/animes/splashscreen_animation.json"),
      ),
      nextScreen: InitScreen(
        currentSelectedIndex: 0,
      ),
      splashIconSize: 400,
      backgroundColor: Color(0xFF181C14),
    );
  }
}
