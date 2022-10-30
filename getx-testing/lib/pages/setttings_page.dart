import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Text('Setting Page'),DrawerHeader(child: Column())
          ],
        ),
      ),
      body: const ListTile(),
    );
  }
}
