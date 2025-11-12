import 'package:flutter/material.dart';

void main() => runApp(LayoutApp());

class LayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Row, Column & Stack')),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text('🔽 Column Layout', style: style),
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  box('Box 1', Colors.red),
                  box('Box 2', Colors.green),
                  box('Box 3', Colors.orange),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('➡️ Row Layout', style: style),
            Container(
              color: Colors.green[50],
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  box('A', Colors.purple),
                  box('B', Colors.teal),
                  box('C', Colors.indigo),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('🧱 Stack Layout', style: style),
            Container(
              height: 180,
              color: Colors.grey[300],
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 160, height: 160, color: Colors.yellow),
                  Container(width: 100, height: 100, color: Colors.blue),
                  Container(width: 50, height: 50, color: Colors.red),
                  Text('Stacked!', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // helper widget
  Widget box(String txt, Color c) => Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(12),
        color: c,
        child: Center(child: Text(txt, style: TextStyle(color: Colors.white))),
      );

  TextStyle get style =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}
