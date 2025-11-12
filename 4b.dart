import 'package:flutter/material.dart';

void main() => runApp(NavRouteApp());

class NavRouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Named Routes Demo',
        initialRoute: '/',
        routes: {
          '/': (_) => First(),
          '/second': (_) => Second(),
        },
      );
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('First Screen')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Route: /',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/second'),
                child: Text('Go to Second Screen'),
              ),
            ],
          ),
        ),
      );
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Second Screen')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Route: /second',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      );
}
