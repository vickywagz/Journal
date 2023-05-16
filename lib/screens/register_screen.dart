import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journal/firebase_options.dart';

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
        title: const Text('RegisterPage'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListView(
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
                      top: 10,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 10),
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Weak password');
                          } else if (e.code == 'invalid-email') {
                            print('The email entered is invalid');
                          } else if (e.code == 'email-already-in-use') {
                            print('Email is already in use');
                          } else {
                            print('something else happened ');
                            print(e.code);
                          }
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
                        print('log in');
                      },
                      child: const Text('Already have an account? Log in!'),
                    ),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
