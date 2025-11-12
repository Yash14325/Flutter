import 'package:flutter/material.dart';

void main() => runApp(DebugApp());

class DebugApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Debug Demo',
        home: Scaffold(
          appBar: AppBar(title: Text('Flutter Debug Demo')),
          body: DebugWidget(),
        ),
      );
}

class DebugWidget extends StatefulWidget {
  @override
  State<DebugWidget> createState() => _DebugWidgetState();
}

class _DebugWidgetState extends State<DebugWidget> {
  int count = 0;

  void inc() {
    setState(() {
      count++;
      debugPrint('Counter incremented: $count');
    });
  }

  void dec() {
    setState(() {
      count--;
      debugPrint('Counter decremented: $count');
      assert(count >= 0, 'Counter should not go negative!');
    });
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $count', style: TextStyle(fontSize: 28)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: inc, child: Text('Increment')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: dec, child: Text('Decrement')),
              ],
            ),
          ],
        ),
      );
}
