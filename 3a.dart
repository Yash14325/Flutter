import 'package:flutter/material.dart';

void main() => runApp(RespApp());

class RespApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Responsive UI')),
        body: ResponsiveLayout(),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, c) {
      if (c.maxWidth < 600) return _mobile();
      if (c.maxWidth < 900) return _tablet();
      return _desktop();
    });
  }

  Widget _mobile() => Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _title('Mobile Layout'),
            SizedBox(height: 20),
            _box(Colors.blue, 150),
            SizedBox(height: 20),
            _box(Colors.green, 150),
          ],
        ),
      );

  Widget _tablet() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            _title('Tablet Layout'),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_box(Colors.blue, 200), _box(Colors.green, 200)],
            )
          ],
        ),
      );

  Widget _desktop() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
        child: Column(
          children: [
            _title('Desktop Layout'),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _box(Colors.blue, 250),
                _box(Colors.green, 250),
                _box(Colors.orange, 250)
              ],
            )
          ],
        ),
      );

  Widget _title(String t) =>
      Text(t, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

  Widget _box(Color c, double s) => Container(
        width: s,
        height: s,
        color: c,
        alignment: Alignment.center,
        child: Text('Box', style: TextStyle(color: Colors.white, fontSize: 18)),
      );
}
