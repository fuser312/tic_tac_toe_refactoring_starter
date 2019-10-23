import 'package:flutter/material.dart';

import 'gamelogic.dart';


class OneBox extends StatefulWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;
  OneBox(
      {this.buttonChild = const Text(''),
        this.onPressed,
        this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
}

class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin {
  AnimationController myController;

  @override
  void initState() {
    myController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
    CurvedAnimation(parent: myController, curve: Curves.bounceOut);
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        myController.forward();
      },
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: myController,
          child: ScaleTransition(
              scale: Tween(begin: 2.5, end: 1.0).animate(smoothAnimation),
              child: widget.buttonChild),
        ),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),
    );
  }
}


class AnimatedStatus extends StatefulWidget{
  @override
  _AnimatedStatusState createState() => _AnimatedStatusState();
}

class _AnimatedStatusState extends State<AnimatedStatus> with SingleTickerProviderStateMixin{

  AnimationController myController;
  @override
  void initState() {
    myController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    //add status listener to get blinking effect
    myController.addStatusListener((AnimationStatus buttonAnimationStatus) {
      if (buttonAnimationStatus == AnimationStatus.completed) {
        myController.reverse();
      } else if (buttonAnimationStatus == AnimationStatus.dismissed) {
        myController.forward();
      }
    });
    myController.addListener(() {
      setState(() {});
    });
    myController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
    CurvedAnimation(parent: myController, curve: Curves.bounceIn);
    return Transform.scale(
      scale: Tween(begin: 1.0, end: 2.0).transform(smoothAnimation.value),
      child:Text(getCurrentStatus(),style: TextStyle(fontSize:25,fontFamily: 'Quicksand',color: ColorTween(begin: Color(0xFF848AC1), end: Colors.red).transform(myController.value),),),
    );
  }}