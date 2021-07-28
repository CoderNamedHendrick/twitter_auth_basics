import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Auth Basics'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.blueAccent,
          disabledColor: Colors.blueAccent,
          elevation: 8,
          onPressed: null,
          child: Text(
            'Sign-in with Twitter',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
