import 'package:flutter/material.dart';

void main() => runApp(ThemeDemo());

class ThemeDemo extends StatefulWidget {
  @override
  State<ThemeDemo> createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<ThemeDemo> {
  bool dark = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.blue),
        darkTheme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.deepPurple),
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(
          appBar: AppBar(title: Text('Theme Demo')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Hello Flutter!',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => setState(() => dark = !dark),
                  child: Text(dark ? 'Switch to Light' : 'Switch to Dark'),
                ),
              ],
            ),
          ),
        ),
      );
}
