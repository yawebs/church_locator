import 'package:flutter/material.dart';

class ChurchFilterScreen extends StatefulWidget {
  @override
  _ChurchFilterScreenState createState() => _ChurchFilterScreenState();
}

class _ChurchFilterScreenState extends State<ChurchFilterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'this'),
          )
        ],
      ),
    );
  }
}
