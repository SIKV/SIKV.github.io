import 'package:cv/colors.dart';
import 'package:flutter/material.dart';

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This page is in development.',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}