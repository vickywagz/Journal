import 'package:flutter/material.dart';
import 'package:journal/constants/routes.dart';
import 'package:journal/service/auth/auth_exception.dart';
import 'package:journal/service/auth/auth_service.dart';
import 'package:journal/utilities/show_error_dialog.dart';

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
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firbase().logIn(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firbase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    //user's email is verified
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      mainRoute,
                      (route) => false,
                    );
                  } else {
                    // user's email is NOT verified
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }
                } on UserNotFoundAuthException {
                  await showErroraialog(
                    context,
                    'User not found',
                  );
                } on WrongPasswordAuthException {
                  await showErroraialog(
                    context,
                    'Wrong credentials',
                  );
                } on GenericAuthException {
                  await showErroraialog(
                    context,
                    'Authentication error',
                  );
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
                  registerRoute,
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
