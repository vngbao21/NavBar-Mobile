import 'package:flutter/material.dart';

class UpcomingLayout extends StatefulWidget {
  const UpcomingLayout({super.key});

  @override
  State<UpcomingLayout> createState() => _UpcomingLayoutState();
}

class _UpcomingLayoutState extends State<UpcomingLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upcoming')),
      body: Column(children: []),
    );
  }
}
