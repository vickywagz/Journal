import 'package:flutter/material.dart';
import 'package:journal/constants/routes.dart';
import 'package:journal/service/auth/auth_exception.dart';
import 'package:journal/service/auth/auth_service.dart';
import 'package:journal/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
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
              'Kindly input your details let\'s get you started',
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
                  await AuthService.firbase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firbase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  await showErroraialog(
                    context,
                    'Weak password',
                  );
                } on EmailAlreadyInUseAuthException {
                  await showErroraialog(
                    context,
                    'Email is already in use',
                  );
                } on InvalidEmailAuthException {
                  await showErroraialog(
                    context,
                    'The email entered is invalid',
                  );
                } on GenericAuthException {
                  await showErroraialog(
                    context,
                    'Faild to register',
                  );
                }
              },
              child: const Text('Register'),
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
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Already have an account? Log in!'),
            ),
          ),
        ],
      ),
    );
  }
}
