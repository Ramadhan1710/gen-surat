import 'package:flutter/material.dart';

class RantingHomePage extends StatefulWidget {
  const RantingHomePage({super.key});

  @override
  State<RantingHomePage> createState() => _RantingHomePageState();
}

class _RantingHomePageState extends State<RantingHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ranting Home Page',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}