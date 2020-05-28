import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget child;

  const CustomDrawer({Key key, this.child}) : super(key: key);
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {

  static const Duration toggleDuration = Duration(milliseconds: 300);
  static const double maxSlide = 250;
  static const double minDragEdge = 60;
  static const double maxDragEdge = maxSlide - 20 ;
  AnimationController _animationController;
  bool _canDrag = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _CustomDrawerState.toggleDuration,
    );
  }

  void close() => _animationController.reverse();
  void open() => _animationController.forward();
  void toggleDrawer() => _animationController.isCompleted ? close() : open();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_animationController.isCompleted){
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          child: widget.child,
          builder: (context,child){
            double animValue = _animationController.value;
            final slide = maxSlide * animValue;
            final contentScale = 1.0 - (0.3 * animValue);
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()..translate(slide)..scale(contentScale,contentScale),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: toggleDrawer,
                    child: Material(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Hello')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenLeft = _animationController.isDismissed && details.globalPosition.dx < minDragEdge;
    bool isDragCloseRight = _animationController.isCompleted && details.globalPosition.dx > maxDragEdge;

    _canDrag = isDragOpenLeft || isDragCloseRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if(_canDrag){
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details){
    double _fling = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted){
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _fling){
      double visualVelocity = details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    }
    else if(_animationController.value < 0.5){
      close();
    }
    else {
      open();
    }
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Colors.transparent,
                      onPressed: (){},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                        mainAxisSize: MainAxisSize.min,
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
                        mainAxisSize: MainAxisSize.min,
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
                        mainAxisSize: MainAxisSize.min,
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
                        mainAxisSize: MainAxisSize.min,
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
        ),
      ),
    );
  }
}
