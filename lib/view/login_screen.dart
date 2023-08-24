import 'package:flutter/material.dart';
import 'package:mvvm/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int age = 35;
    print("$age");
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Utils.flushBarErrorMessage("No Internet connection", context);
          },
          child: const Text("click me"),
        ),
      ),
    );
  }
}
