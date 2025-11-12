import 'package:flutter/material.dart';

void main() => runApp(MediaDemo());

class MediaDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediaQuery Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Responsive UI')),
        body: ResponsiveBox(),
      ),
    );
  }
}

class ResponsiveBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if (w < 600) return layout('Mobile', Colors.blue, 150, 18);
    if (w < 900) return layout('Tablet', Colors.green, 300, 24);
    return layout('Desktop', Colors.orange, 450, 30);
  }

  Widget layout(String text, Color c, double size, double fs) => Center(
        child: Container(
          color: c,
          width: size,
          height: size,
          alignment: Alignment.center,
          child:
              Text('$text Layout', style: TextStyle(color: Colors.white, fontSize: fs)),
        ),
      );
}
