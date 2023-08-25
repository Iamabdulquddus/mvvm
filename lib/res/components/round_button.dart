import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;

  const RoundButton({super.key, required this.title, required this.onPress,  this.loading = false,});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child:loading? const CircularProgressIndicator(color: Colors.green,): Container(height: 50,width: 200,decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
        child: Center(
          child:  Text(title, style: const TextStyle(fontSize: 18, color: AppColors.whiteColor),),
        ),
      ),
    );
  }
}
