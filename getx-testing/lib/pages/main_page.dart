import 'package:flutter/material.dart';
import 'package:getx_testting/helper/helper_function.dart';
import 'package:getx_testting/screen/home_screen.dart';
import 'package:getx_testting/screen/signup_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool  _isSingedIn = false;
  @override
  
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      
        setState(() {
          if (value != null) {
          _isSingedIn = value;
        }
        });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isSingedIn? const HomePage():  SignUpScreen(),
    );
  }
}
