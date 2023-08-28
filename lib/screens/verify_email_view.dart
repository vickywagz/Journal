import 'package:flutter/material.dart';
import 'package:journal/constants/routes.dart';
import 'package:journal/service/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text(
              'we\'ve sent you an email verification. Please open it to verify your account.'),
          const Text(
              'if you havn\'t received a verification email yet, press the button below'),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firbase().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firbase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
