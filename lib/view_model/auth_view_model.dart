import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignupLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString(),
        ),
      );

      Utils.toastMessage("Login Successful");
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print("login value: ${value.toString()}");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setSignupLoading(true);
    _myRepo.loginApi(data).then((value) {
      setSignupLoading(false);
      Utils.flushBarErrorMessage("Signup Successful", context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignupLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
