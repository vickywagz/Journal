import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journal/firebase_options.dart';
import 'package:journal/screens/login_screen.dart';
import 'package:journal/screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 199, 45, 34),
        ),
        useMaterial3: false,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //   final user = FirebaseAuth.instance.currentUser;
            //   if (user?.emailVerified ?? false) {
            //     return const Text('Done');
            //   } else {
            //     return const VerifyEmailView();
            //   }
            return const LoginView();
          default:
            return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
