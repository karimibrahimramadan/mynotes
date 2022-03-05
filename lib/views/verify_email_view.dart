import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Verify Email',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "We've sent a verification email, please open it to verify your account",
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "If you haven't received a verification email click the button",
              ),
              TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  print(user);
                  await user?.sendEmailVerification();
                },
                child: const Text(
                  'Send email verification',
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text(
                  'Restart',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
