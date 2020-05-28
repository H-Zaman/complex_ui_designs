import 'package:flutter/material.dart';
import 'dart:math' as math;

class DTransition extends StatefulWidget {
  @override
  _DTransitionState createState() => _DTransitionState();
}

class _DTransitionState extends State<DTransition> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  bool _canBeDragged = false;
  final double maxSlide = 300;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void toggle() => animationController.isDismissed ? animationController.forward() : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _){
          return Material(
            //main page color
            color: Colors.blue,
            child: Stack(
              children: <Widget>[
                //hidden drawer
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(math.pi / 2 * (1-animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MDrawer(),
                  ),
                ),
                //icon to toggle
                Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggle,
                    color: Colors.white,
                  ),
                ),
                //Main Page
                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: animationController.value * MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Text(
                      'Hello',textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details){
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details){
    if(_canBeDragged){
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details){
    double _fling = 365.0;

    if (animationController.isDismissed || animationController.isCompleted){
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _fling){
      double visualVelocity = details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    }
    else if(animationController.value < 0.5){
      animationController.reverse();
    }
    else {
      animationController.forward();
    }
  }
}

class MDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Material(
        color: Colors.lightBlue,
        child: SafeArea(
          //wrap theme > themedata > brigtness  Brightness.dark
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.new_releases),
                      Text('New')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.warning),
                      Text('Warning')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.archive),
                      Text('Archive')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.near_me),
                      Text('Near Me')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      Text('Profile')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

