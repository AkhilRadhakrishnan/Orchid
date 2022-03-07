import 'package:flutter/material.dart';

import '../views/home_screen.dart';

// import 'package:servcon_app/screens/login/login_test.dart';


class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
    builder: builder,
    settings: settings,
  );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    if (settings.name == HomeScreen.routeName) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
