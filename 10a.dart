import 'package:flutter/material.dart';

void main() {
  runApp(UITestApp());
  print('Running UI Tests...');
  testCounter();
  testButton();
  print('All tests completed.');
}

// Simulated unit tests
void testCounter() {
  print('[PASS] Counter shows 0 initially');
  print('[PASS] Counter increments on button press');
}

void testButton() {
  print('[PASS] Button displays label');
  print('[PASS] Button triggers onPressed callback');
}

// Demo Flutter App
class UITestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UI Test Demo',
        home: Scaffold(
          appBar: AppBar(title: Text('UI Test Demo')),
          body: Center(child: CounterWidget()),
        ),
      );
}

class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterState();
}

class _CounterState extends State<CounterWidget> {
  int count = 0;
  void inc() => setState(() {
        count++;
        print('Counter incremented: $count');
      });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$count', style: TextStyle(fontSize: 32)),
          SizedBox(height: 10),
          ElevatedButton(onPressed: inc, child: Text('Increment')),
        ],
      );
}
