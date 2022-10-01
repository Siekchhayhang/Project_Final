import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_testting/screen/home_screen.dart';
import 'package:getx_testting/screen/google_signing_screen.dart';
import 'package:getx_testting/screen/signup_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Login'),
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
                decoration: const InputDecoration(labelText: 'Enter Password'),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: context.width),
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.blue,
                          child: const Text('Login'),
                          onPressed: () => login(
                            userController.text.trim(),
                            passwordController.text.trim(),
                          ),
                        ),
                      ),

                      // const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Are you new member?',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          TextButton(
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            onPressed: () => Get.to(SignUpScreen()),
                          ),
                        ],
                      ),
                      TextButton(
                        child: const Text(
                          'Click here for Login with Google',
                          style: TextStyle(
                              color: Colors.blue, fontSize: 16),
                        ),
                        onPressed: () => Get.to(const GoogleSigninPage()),
                      ),

                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future login(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password)
          .then((value) {
        Get.to(const HomePage());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: Text('Invalid UserName, please check it again!'),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: Text('Invalid Password, please check it again!'),
            );
          },
        );
      }
      // showDialog(
      //   context: Get.context!,
      //   builder: (context) {
      //     return const AlertDialog(
      //       content: Text('Please fill all information'),
      //     );
      //   },
      // );
    }
  }
}
