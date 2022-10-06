import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Sign Up Page'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userController,
                decoration: const InputDecoration(labelText: 'Enter UserName'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                maxLength: 16,
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
              TextField(
                obscureText: true,
                maxLength: 16,
                controller: confirmpasswordController,
                decoration:
                    const InputDecoration(labelText: 'Enter Confirm Password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    color: Colors.blue,
                    child: const Text('Sign Up'),
                    onPressed: () => signUp(
                      userController.text.trim(),
                      passwordController.text.trim(),
                      confirmpasswordController.text.trim(),
                      
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signUp(
      String username, String password, String confirmpassword) async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: username,
          password: password,
        )
            .then((value) {
          Get.to(LoginScreen());
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: Text('The account already exists for that email.'),
            );
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
}
