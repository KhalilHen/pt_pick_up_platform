import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/onboarding/page_view_model.dart';
import 'package:pt_pick_up_platform/onboarding/pages/introduction.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pt_pick_up_platform/pages/homepage.dart';

class Introduction extends StatefulWidget {
  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      showNextButton: false,
      showDoneButton: false,
      globalBackgroundColor: Colors.white,
      animationDuration: 1000,
      curve: Curves.easeInOut,
      dotsDecorator: DotsDecorator(
        activeColor: Colors.deepOrange,
        size: Size.square(8.0),
        activeSize: Size(16.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChange: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      globalFooter: Container(
        padding: const EdgeInsets.all(16.0),
        child: Visibility(
          visible: currentIndex == (getPages().length - 1),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.deepOrange),
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ),
              );
            },
            child: const Text(
              "Get Started",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
