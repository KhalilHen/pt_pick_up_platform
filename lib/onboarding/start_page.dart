import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/onboarding/page_view_model.dart';
import 'package:pt_pick_up_platform/onboarding/pages/introduction.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
      showDoneButton: false,
      animationDuration: 1000,
      curve: Curves.easeInOut,
    );
  }
}
