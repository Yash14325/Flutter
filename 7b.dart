import 'package:flutter/material.dart';

void main() => runApp(FormApp());

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        home: FormPage(),
      );
}

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _key = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();

  void submit() {
    if (_key.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Form submitted successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Form Validation')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Name is required' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email is required';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v))
                      return 'Enter a valid email';
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(onPressed: submit, child: Text('Submit')),
              ],
            ),
          ),
        ),
      );
}
