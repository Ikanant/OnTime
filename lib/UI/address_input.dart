import 'package:flutter/material.dart';
import 'dart:math';

class AddressInput extends StatefulWidget {
  String _originAddress = "";

  String get address => _originAddress;

  @override
  State createState() => new AddressInputState();
}

class AddressInputState extends State<AddressInput> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
        child: new Center(
          child: new TextField(
            onChanged: (text) { widget._originAddress = _controller.text; },
            controller: _controller,
            decoration: new InputDecoration(
              hintStyle: new TextStyle(
                color: Colors.white
              ),
              hintText: "Type something"
            ),
            style: new TextStyle(
              color: Colors.white
            ),
          ),
        ),
      )
    );
  }
}