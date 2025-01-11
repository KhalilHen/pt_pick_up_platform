import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenDemo extends StatefulWidget {
  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {
  // 1. Define a `GlobalKey` as part of the parent widget's state
  final onboardingKey = GlobalKey<IntroductionScreenState>();
  String _status = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    return PageViewModel(
      key: onboardingKey,
      pages: [


      ],
      showNextButton: false,
      showDoneButton: false,
    );
  }
}
