import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
              title: "Login",
              loading: authViewModel.loading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter Email", context);
                } else if (_passwordController.text.isEmpty &&
                    _passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      "Please enter 6 digit password", context);
                } else {
                  Map data = {
                    'email':
                        'eve.holt@reqres.in', //_emailController.text.toString(),
                    'password':
                        'cityslicka', //_passwordController.text.toString(),
                  };
                  authViewModel.loginApi(data, context);
                  if (kDebugMode) {
                    print('api hit');
                  }
                }
              }),
          SizedBox(
            height: height * 0.1,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.signup);
            },
            child: Text("Don't have an account  "),
          )
        ],
      ),
    );
  }
}
