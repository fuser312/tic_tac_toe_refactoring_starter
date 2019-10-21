import 'package:flutter/material.dart';

class OneBox extends StatelessWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;
  OneBox(
      {this.buttonChild = const Text(''),
        this.onPressed,
        this.colors = Colors.white24});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: buttonChild == null ? 0.0 : 1.0,
            child: buttonChild),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
