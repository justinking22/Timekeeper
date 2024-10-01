import 'package:flutter/material.dart';
import 'package:timekeeper/app/sign_in/email_sign_in_form.dart';
import 'package:timekeeper/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        title: const Text(
          'Sign In',
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm(
              auth: auth,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
