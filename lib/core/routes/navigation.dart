import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static push(BuildContext context, String screenName) {
    return context.push(screenName);
  }

  static pop(BuildContext context) {
    return context.pop(context);
  }

  static pushAndRemoveUntil(BuildContext context, String screenName) {
    return context.go(screenName);
  }

  static pushReplacement(BuildContext context, String screenName) {
    return context.pushReplacement(screenName);
  }
}
