import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(ApiDemo());

class ApiDemo extends StatelessWidget {
  Future<String> getAdvice() async {
    final res = await http.get(Uri.parse('https://api.adviceslip.com/advice'));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return data['slip']['advice'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Fetch REST API Data')),
          body: Center(
            child: FutureBuilder<String>(
              future: getAdvice(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if (snap.hasError) return Text('Error: ${snap.error}');
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    snap.data ?? 'No data',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
