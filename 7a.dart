// 7a.dart
import 'package:flutter/material.dart';

void main() => runApp(StudentFormApp());

class StudentFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Form',
        home: StudentFormPage(),
      );
}

class StudentFormPage extends StatefulWidget {
  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '', roll = '', gender = 'Male';

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Submitted Info'),
        content: Text('Name: $name\nRoll No: $roll\nGender: $gender'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Student Details Form')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (v) => name = v ?? '',
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Roll No'),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => roll = v ?? '',
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter roll no' : null,
                ),
                SizedBox(height: 16),
                Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(value: 'Male', groupValue: gender, onChanged: (v) => setState(() => gender = v!)),
                    Text('Male'),
                    SizedBox(width: 20),
                    Radio<String>(value: 'Female', groupValue: gender, onChanged: (v) => setState(() => gender = v!)),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _submit, child: Text('Submit')),
              ],
            ),
          ),
        ),
      );
}
