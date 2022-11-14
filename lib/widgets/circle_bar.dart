import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircleBar extends StatefulWidget {
  final bool isActive;
  const CircleBar(this.isActive, {super.key});

  @override
  State<CircleBar> createState() => _CircleBarState();
}

class _CircleBarState extends State<CircleBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: widget.isActive ? 12 : 8,
      width: widget.isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: widget.isActive ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
    ;
  }
}
