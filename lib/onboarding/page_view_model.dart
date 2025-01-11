import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/onboarding/pages/ending_page.dart';
import 'package:pt_pick_up_platform/onboarding/pages/explain_page.dart';
import 'package:pt_pick_up_platform/onboarding/pages/introduction.dart';

List<PageViewModel> getPages() {
  return [startPage(), explainPage(), endingPage()];
}
