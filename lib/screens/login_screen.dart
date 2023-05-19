import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'image/giphy.gif',
            image:
                'https://images.pexels.com/photos/289998/pexels-photo-289998.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
          const Center(
            child: Text(
              'Kindly input your credentials to get started',
              style: TextStyle(
                height: 2,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: '  Enter your email here',
            ),
          ),
          TextFormField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: '  Enter your password here',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 60,
              right: 60,
              top: 20,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 10),
              onPressed: () async {
                try {
                  final email = _email.text;
                  final password = _password.text;
                  final userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('User not found');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password');
                  } else {
                    print('Something else happened');
                    print(e.code);
                  }
                }
              },
              child: const Text('Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 60,
              right: 60,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 10),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/register/',
                  (route) => false,
                );
              },
              child: const Text('Not registered? Register here!'),
            ),
          ),
        ],
      ),
    );
  }
}
