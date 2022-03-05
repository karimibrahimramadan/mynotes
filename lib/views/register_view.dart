import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _emailController.text;
              final password = _passwordController.text;
              FirebaseAuth _auth = FirebaseAuth.instance;
              try {
                final userCredential =
                    await _auth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } on FirebaseException catch (e) {
                if (e.code == 'email-already-in-use') {
                  print('Email is already in use');
                } else if (e.code == 'invalid-email') {
                  print('Invalid email');
                } else if (e.code == 'weak-password') {
                  print('Password must be at least 6 characters');
                } else {
                  print(e.code);
                }
              }
            },
            child: const Text(
              'Register',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text(
              'Already registered? Login here!',
            ),
          ),
        ],
      ),
    );
  }
}
