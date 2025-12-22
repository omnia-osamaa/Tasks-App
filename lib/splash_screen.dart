import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'OnboardingScreens');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5F33E1),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeInLeft(
              duration: Duration(milliseconds: 700),
              child: Image.asset("assets/icons/Taskyy.png", width: 80),
            ),
            BounceInDown(
              delay: Duration(milliseconds: 700),
              duration: Duration(milliseconds: 300),
              from: 50,
              child: Padding(
                padding: EdgeInsets.only(left: 110),
                child: Image.asset("assets/icons/yyy.png", width: 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
