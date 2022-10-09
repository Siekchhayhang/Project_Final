import 'package:flutter/material.dart';
import 'package:getx_testting/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == 2;
          });
        },
        children: const  [
          OnboardWidgets(
            image: 'assets/images/welcome-greeting-message.png',
            subtitle:
                'Welcome to our company! We\'re so excited to have you as part of our team.',
            color: Colors.white,
          ),
           OnboardWidgets(
            image: 'assets/images/our-services.png',
            subtitle:
                'Essay writing services offer multiple academic and professional types of writing to cater to their customers needs. You can order an admission essay, creative writing essay, research paper lab report or any other type of academic writing for a price.',
            color: Colors.white10,
          ),
           Center(
             child: OnboardWidgets(
              image: 'assets/images/get-start.png',
              subtitle:
                  'Join Us for more detials.',
              color: Colors.white,
          ),
           )
        ],
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        color: Colors.grey[300],
        height: 50,
        child: isLastPage
            ? TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Get Started'),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: const Text('SKIP'),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      spacing: 16.0,
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: Colors.white,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('NEXT'),
                  ),
                ],
              ),
      ),
    );
  }
}
