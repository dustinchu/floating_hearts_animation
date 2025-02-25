import 'package:floating_hearts_animation/floating_hearts_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Hearts Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Hearts Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingHeartsButton(
                  svgPath: 'assets/heart.svg',
                  onTap: () => print('Tapped!'),
                  size: 50,
                  floatingItemCount: 3,
                  animationDuration: Duration(milliseconds: 2000),
                  itemDelay: Duration(milliseconds: 150),
                  animationType: FloatingAnimationType.curve,
                ),
                FloatingHeartsButton(
                  svgPath: 'assets/Family.svg',
                  onTap: () => print('Tapped!'),
                  size: 50,
                  floatingItemCount: 3,
                  animationDuration: Duration(milliseconds: 2000),
                  itemDelay: Duration(milliseconds: 150),
                  animationType: FloatingAnimationType.curve,
                ),
              ],
            ),
            const SizedBox(height: 90),
            FloatingHeartsButton(
              child: Icon(Icons.favorite, color: Colors.red, size: 50),
              onTap: () => print('Tapped!'),
              floatingItemCount: 4,
              animationType: FloatingAnimationType.random,
            ),
            const SizedBox(height: 20),
            Text(
              'You tapped the heart $_counter times',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
