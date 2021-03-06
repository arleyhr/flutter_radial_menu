import 'package:flutter/material.dart';
import 'package:animated_radial_menu/radial_menu.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: SizedBox.expand(child: RadialMenu(),),
        )
      ),
    );
  }
}
