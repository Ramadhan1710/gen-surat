import 'package:flutter/material.dart';

class AnggotaHomePage extends StatefulWidget {
  const AnggotaHomePage({super.key});

  @override
  State<AnggotaHomePage> createState() => _AnggotaHomePageState();
}

class _AnggotaHomePageState extends State<AnggotaHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Anggota Home Page',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
