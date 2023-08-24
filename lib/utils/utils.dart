import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    print("something");
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }
}
