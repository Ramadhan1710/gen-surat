import 'package:flutter/material.dart';

class SekretarisHomePage extends StatefulWidget {
  const SekretarisHomePage({super.key});

  @override
  State<SekretarisHomePage> createState() => _SekretarisHomePageState();
}

class _SekretarisHomePageState extends State<SekretarisHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Sekretaris Home Page',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
