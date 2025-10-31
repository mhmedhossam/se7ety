import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static push(BuildContext context, String screenName, [extra]) {
    return context.push(screenName, extra: extra);
  }

  static pop(BuildContext context) {
    return context.pop(context);
  }

  static pushAndRemoveUntil(BuildContext context, String screenName, [extra]) {
    return context.go(screenName, extra: extra);
  }

  static pushReplacement(BuildContext context, String screenName, [extra]) {
    return context.pushReplacement(screenName, extra: extra);
  }
}
