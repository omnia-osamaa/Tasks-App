import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasky/feature/auth/ui/view/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});
  static const String routeName = 'OnboardingScreens';
  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  List<OnboardingData> OnboardingList = dataOnboarding();
  int index = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: 260,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return CustomAnimation(
                      index: index,
                      delay: index,
                      child: Image.asset(OnboardingList[index].image),
                    );
                  },
                  itemCount: OnboardingList.length,
                )),
            SmoothPageIndicator(
              controller: pageController,
              count: OnboardingList.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Color(0xff5F33E1),
                dotHeight: 5,
                dotWidth: 15,
                expansionFactor: 4,
                spacing: 10,
                radius: 10,
              ),
            ),
            CustomAnimation(
              index: index,
              delay: index * 200,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      OnboardingList[index].title,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      OnboardingList[index].body,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  onPressed: () {
                    if (index < OnboardingList.length - 1) {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    }
                  },
                  color: Color(0xff5F33E1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      index < OnboardingList.length - 1
                          ? "Next"
                          : "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String body;

  OnboardingData({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<OnboardingData> dataOnboarding() {
  return [
    OnboardingData(
      image: 'assets/images/onboarding_1.png',
      title: 'Manage your tasks',
      body: 'You can easily manage all of your daily tasks in DoMe for free.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_2.png',
      title: 'Create daily routine',
      body:
          'In Tasky you can create your personalized routine to stay productive.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_3.png',
      title: 'Organize your tasks',
      body:
          'You can organize your daily tasks by adding your tasks into separate categories.',
    ),
  ];
}

class CustomAnimation extends StatelessWidget {
  CustomAnimation(
      {super.key,
      required this.index,
      required this.delay,
      required this.child});
  final int index;
  final int delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    } else if (index == 2) {
      return FadeInUp(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    } else {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
  }
}
