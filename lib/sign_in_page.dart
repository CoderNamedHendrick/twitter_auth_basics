import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_auth_basics/auth.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Home Page"),
                centerTitle: true,
              ),
              body: Center(
                child: RaisedButton(
                  child: Text('Sign Out'),
                  onPressed: () async => await auth.signOut(),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Twitter Auth Basics'),
            ),
            body: Center(
              child: RaisedButton(
                color: Colors.blueAccent,
                disabledColor: Colors.blueAccent,
                elevation: 8,
                onPressed: () async => await auth.signInWithTwitter(),
                child: Text(
                  'Sign-in with Twitter',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
