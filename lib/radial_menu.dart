import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: _controller);
  }
}


class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale;

  RadialAnimation({Key key, this.controller }) : 
      
    scale = Tween<double>(
      begin: 1.5,
      end: 0
    ).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),

  super(key: key);
  
  _open () {
    controller.forward();
  }

  _close () {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, builder) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.scale(
              scale: scale.value -1,
              child: FloatingActionButton(
                child: Icon(Icons.cancel),
                onPressed: _close,
                backgroundColor: Colors.red,
              ),
            ),
            Transform.scale(
              scale: scale.value,
              child: FloatingActionButton(
                child: Icon(Icons.supervised_user_circle),
                onPressed: _open,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}
