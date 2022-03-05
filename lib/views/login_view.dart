import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../constants/routes.dart';
import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          'Login',
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
                final userCredential = await _auth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                  (route) => false,
                );
              } on FirebaseException catch (e) {
                if (e.code == 'invalid-email') {
                  await showErrorDialog(
                    context,
                    'Invalid email',
                  );
                } else if (e.code == 'user-not-found') {
                  await showErrorDialog(
                    context,
                    'User not found',
                  );
                } else if (e.code == 'wrong-password') {
                  await showErrorDialog(
                    context,
                    'Wrong password',
                  );
                } else {
                  await showErrorDialog(
                    context,
                    'Error: ${e.code}',
                  );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  'Error: ${e.toString()}',
                );
              }
            },
            child: const Text(
              'Login',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text(
              'Not registered yet? Register here!',
            ),
          ),
        ],
      ),
    );
  }
}
