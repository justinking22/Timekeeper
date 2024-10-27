import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timekeeper/common_widgets/avatar.dart';
import 'package:timekeeper/common_widgets/show_alert_dialog.dart';
import 'package:timekeeper/services/auth.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Log Out',
        content: 'Are you sure you want to log out?',
        defaultActionText: 'Ok',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Account',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => _confirmSignOut(context),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: _buildUserInfo(auth.currentUser)),
      ),
    );
  }

  _buildUserInfo(User? user) {
    return Column(
      children: [
        Avatar(
          photoUrl: user!.photoURL!,
          radius: 50,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName!,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
