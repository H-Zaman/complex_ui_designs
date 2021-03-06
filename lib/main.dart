import 'package:complexuidesigns/ui/3d_transition_ui.dart';
import 'package:complexuidesigns/ui/custom_drawer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/3d' : (context) => DTransition(),
        '/cus' : (context)=> CustomDrawer(),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/3d');
              },
              child: Text('3D Transition'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cus');
              },
              child: Text('Custom Drawer'),
            )
          ],
        ),
      ),
    );
  }
}
