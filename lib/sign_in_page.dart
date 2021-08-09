import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_auth_basics/auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          User user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("Home Page"),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Display Name: ${user.displayName}'),
                Text('User email: ${user.email}'),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('Sign Out'),
                  onPressed: () async {
                    await auth.signOut();
                    setState(() {});
                  },
                ),
              ],
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
              onPressed: () async {
                await auth.signInWithTwitter();
                setState(() {});
              },
              child: Text(
                'Sign-in with Twitter',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
