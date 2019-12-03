import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  void _incrementCounter() {
    if (controller.isAnimating) {
      controller.stop();
    } else if (controller.isCompleted) {
      controller.reset();
    } else {
      controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GrowingContainer(
          child: Wrap(
            children: <Widget>[
              // set sdk: ">=2.2.2 <3.0.0"
              for (var i = 0; i < 10; i++)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                      i * 25,
                      i * 25,
                      i * 25,
                      i * 25,
                    ),
                  ),
                ),
            ],
          ),
          controller: this.controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class GrowingContainer extends AnimatedWidget {
  GrowingContainer({this.child, AnimationController controller})
      : super(
            listenable: Tween<double>(begin: 20, end: 200).animate(controller));

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Container(
      height: 200,
      width: animation.value,
      color: Colors.red,
      child: child,
    );
  }
}
