import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(ApiListDemo());

class ApiListDemo extends StatelessWidget {
  Future<List> getPosts() async {
    final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception('Failed to load posts');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Posts from API')),
          body: FutureBuilder<List>(
            future: getPosts(),
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (snap.hasError)
                return Center(child: Text('Error: ${snap.error}'));
              final posts = snap.data ?? [];
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (c, i) => Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(posts[i]['title'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(posts[i]['body']),
                  ),
                ),
              );
            },
          ),
        ),
      );
}
