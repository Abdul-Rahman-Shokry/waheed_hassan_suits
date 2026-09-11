import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/routing/app_router.dart';
import '../core/storage/cache_helper.dart';
import '../core/widgets/app_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (CacheHelper.isFirstTime) {
        context.go(AppRouter.onBoarding);
      } else if (!CacheHelper.isLoggedIn) {
        context.go(AppRouter.login);
      } else {
        context.go(AppRouter.login);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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