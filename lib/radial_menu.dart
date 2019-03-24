import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

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
  final Animation<double> translation;

  RadialAnimation({Key key, this.controller }) :

    scale = Tween<double>(
      begin: 1.5,
      end: 0
    ).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)
    ),
    translation = Tween<double>(
        begin: 0.0,
        end: 100.0
    ).animate(
        CurvedAnimation(parent: controller, curve: Curves.linear)
    ),

  super(key: key);
  
  _open () {
    controller.forward();
  }

  _close () {
    controller.reverse();
  }

  _buildButton(double angle, { Color color, IconData icon }) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad)
      ),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed: _close,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, builder) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildButton(0, color: Colors.red, icon: Icons.ac_unit),
            _buildButton(45, color: Colors.orange, icon: Icons.access_alarm),
            _buildButton(90, color: Colors.green, icon: Icons.add_photo_alternate),
            _buildButton(135, color: Colors.teal, icon: Icons.call),
            _buildButton(180, color: Colors.blue, icon: Icons.blur_circular),
            _buildButton(225, color: Colors.pink, icon: Icons.build),
            _buildButton(270, color: Colors.indigo, icon: Icons.face),
            _buildButton(315, color: Colors.black, icon: Icons.grade),
            Transform.scale(
              scale: scale.value - 1,
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
