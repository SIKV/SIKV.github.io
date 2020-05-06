import 'package:flutter/material.dart';

class SlideTopRoute extends PageRouteBuilder {
  final bool opaque;
  final Widget page;

  SlideTopRoute({this.opaque, this.page}) : super(
    opaque: opaque,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
        FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        )
  );
}