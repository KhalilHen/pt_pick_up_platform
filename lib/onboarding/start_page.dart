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
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      showNextButton: false,
      showDoneButton: true,
      doneStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      animationDuration: 1000,
      curve: Curves.easeInOut,
      done: const Text(
        "Done",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange,
        ),
      ),
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ),
        );
      },
    );
  }
}
