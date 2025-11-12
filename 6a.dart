import 'package:flutter/material.dart';

void main() => runApp(ProfileApp());

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Profile App')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileCard(name: 'John Doe', email: 'john.doe@example.com'),
                SizedBox(height: 20),
                ActionBtn(text: 'Follow', color: Colors.green, onPressed: () {
                  print('Follow button clicked');
                }),
              ],
            ),
          ),
        ),
      );
}

class ProfileCard extends StatelessWidget {
  final String name, email;
  const ProfileCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        margin: EdgeInsets.all(12),
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white)),
          title: Text(name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(email),
        ),
      );
}

class ActionBtn extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  const ActionBtn({required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(text),
      );
}
