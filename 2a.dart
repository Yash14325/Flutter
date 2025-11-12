import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final img =
      'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Widgets')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🌟 Welcome to Flutter!',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Image.network(img, width: 180, errorBuilder: (_, __, ___) {
                return Column(children: [
                  Icon(Icons.error, color: Colors.red),
                  Text('Image failed')
                ]);
              }),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Text('Container with padding & color',
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 10),
                  Icon(Icons.thumb_up, color: Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
