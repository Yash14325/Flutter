import 'package:flutter/material.dart';

void main() => runApp(NavApp());

class NavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Navigator Demo',
        home: First(),
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
              Image.network(
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=60',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Second())),
                child: Text('Go to Second Screen'),
              )
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
              Image.network(
                'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=600&q=60',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Go Back'),
              )
            ],
          ),
        ),
      );
}
