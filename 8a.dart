import 'package:flutter/material.dart';

void main() => runApp(AnimationDemo());

class AnimationDemo extends StatefulWidget {
  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  bool big = false, show = true;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animation Demo',
        home: Scaffold(
          appBar: AppBar(title: Text('Flutter Animations')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => big = !big),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: big ? 200 : 100,
                    height: big ? 200 : 100,
                    color: big ? Colors.blue : Colors.red,
                    alignment: Alignment.center,
                    child: Text('Tap Me',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => setState(() => show = !show),
                  child: Text('Toggle Text'),
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: show ? 1 : 0,
                  child: Text('Hello Flutter!',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      );
}
