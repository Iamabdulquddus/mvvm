import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/res/app_url.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future registerUser() async {
    var regBody = {
      "email": "emailController",
      "password": "passwordController.text"
    };

    var response = await http.post(
      Uri.parse(AppUrl.registerApiEndPoint),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['status']);
  }

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            focusNode: emailFocusNode,
            decoration: const InputDecoration(
              hintText: "Enter Email",
              labelText: "Email",
              prefixIcon: Icon(Icons.alternate_email),
            ),
            onFieldSubmitted: (valu) {
              Utils.fieldFocusChange(
                  context, emailFocusNode, passwordFocusNode);
            },
          ),
          ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: passwordFocusNode,
                  obscureText: _obscurePassword.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: InkWell(
                      onTap: () {
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                      child: _obscurePassword.value
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_rounded),
                    ),
                  ),
                );
              }),
          SizedBox(
            height: height * 0.1,
          ),
          RoundButton(
              title: "Sign Up",
              loading: authViewModel.signupLoading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter Email", context);
                } else if (_passwordController.text.isEmpty &&
                    _passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      "Please enter 6 digit password", context);
                } else {
                  // registerUser();
                  Map data = {
                    'email': "_emailController.text.toString()",
                    'password': "_passwordController.text.toString()",
                  };
                  authViewModel.signupApi(data, context);
                }
              }),
          SizedBox(
            height: height * 0.1,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.login);
            },
            child: const Text("Already have an account  "),
          )
        ],
      ),
    );
  }
}
