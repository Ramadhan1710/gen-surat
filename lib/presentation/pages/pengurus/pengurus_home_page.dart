import 'package:flutter/material.dart';

class PengurusHomePage extends StatefulWidget {
  const PengurusHomePage({super.key});

  @override
  State<PengurusHomePage> createState() => _PengurusHomePageState();
}

class _PengurusHomePageState extends State<PengurusHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Pengurus Home Page',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}