import 'package:flutter/material.dart';

class NavigationBarMyPage extends StatefulWidget {
  @override
  _NavigationBarMyPageState createState() => _NavigationBarMyPageState();
}

class _NavigationBarMyPageState extends State<NavigationBarMyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My Page'),
      ),
    );
  }
}
