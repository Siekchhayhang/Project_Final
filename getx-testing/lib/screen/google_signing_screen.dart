import 'package:flutter/material.dart';
import 'package:getx_testting/screen/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/google_service.dart';

class GoogleSigninPage extends StatefulWidget {
  const GoogleSigninPage({Key? key}) : super(key: key);

  @override
  State<GoogleSigninPage> createState() => _GoogleSigninPageState();
}

class _GoogleSigninPageState extends State<GoogleSigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign in'),
        centerTitle: true,
      ),
      body: Center(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          icon: SizedBox(
            height: 45.0,
            width: 45.0,
            child: Image.asset('assets/images/google-logo.png'),
          ),
          onPressed: () {
            GoogleSigninService().siginWithGoogle();
            setState(
              () {
                GoogleSignIn().signIn();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            );
          },
          label: Text(
            'Signin with Google',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
