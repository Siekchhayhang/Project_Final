import 'package:flutter/material.dart';
import 'package:getx_testting/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Get Start Screen')),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', false);

            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
