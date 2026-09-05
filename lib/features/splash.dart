import 'package:flutter/material.dart';
import 'package:waheed_hassan_suits/core/utils/helper_methods.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/features/onboarding.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  
  @override
  void initState() {
    super.initState();
    goTo(page: OnBoardingView(), delaySeconds: 3, canPop: false);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppImage("waheed.svg"),
      ),
    );
  }
}
