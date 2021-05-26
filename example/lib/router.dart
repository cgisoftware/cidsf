import 'package:cids_cgi_example/constants.dart';
import 'package:cids_cgi_example/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case settingsRoute:
        return SlideRightRoute(widget: settingsPage);
      case authRoute:
        return SlideRightRoute(widget: biometricsPage);

      case homeRoute:
        return SlideRightRoute(widget: homePage);

      case indexRoute: 
        return SlideRightRoute(widget: authPage);

      default:
        return SlideRightRoute(widget: authPage);
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(opacity: animation, child: child),
            transitionDuration: Duration(milliseconds: 500));
}
