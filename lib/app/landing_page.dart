import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timekeeper/app/home_page.dart';
import 'package:timekeeper/app/sign_in/sign_in_page.dart';

import '../services/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({required this.auth});

  late final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return SignInPage(
              auth: auth,
            );
          }
          return HomePage(
            auth: auth,
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
