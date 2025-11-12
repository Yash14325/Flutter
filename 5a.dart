import 'package:flutter/material.dart';

void main() => runApp(StateDemo());

class StateDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Stateless vs Stateful')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatelessPart(),
                SizedBox(height: 20),
                StatefulPart(),
              ],
            ),
          ),
        ),
      );
}

// Stateless Widget
class StatelessPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        color: Colors.orange[200],
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('I am Stateless 😎',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      );
}

// Stateful Widget
class StatefulPart extends StatefulWidget {
  @override
  State<StatefulPart> createState() => _StatefulPartState();
}

class _StatefulPartState extends State<StatefulPart> {
  int count = 0;

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.blue[100],
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('I am Stateful 🌀\nCount: $count',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => setState(() => count++),
                child: Text('Add Count'),
              ),
            ],
          ),
        ),
      );
}
