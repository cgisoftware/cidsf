import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return SlideRightRoute(widget: MyHome());
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
