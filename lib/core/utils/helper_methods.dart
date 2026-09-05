import 'dart:async';

import 'package:flutter/material.dart';

final navKey = GlobalKey<NavigatorState>();

void goTo({required Widget page, bool canPop = true, int? delaySeconds}) {
  action() {
    Navigator.pushAndRemoveUntil(
      navKey.currentContext!,
      MaterialPageRoute(builder: (_) => page),
          (_) => canPop,
    );
  }

  if (delaySeconds != null) {
    Timer(const Duration(seconds: 3), () {
      action();
    });
  } else {
    action();
  }
}

void showMsg(String? msg, {bool isError = false}) {
  if (msg != null && msg.isNotEmpty) {
    ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        content: Text(msg, maxLines: 2,),
      ),
    );
  }
}