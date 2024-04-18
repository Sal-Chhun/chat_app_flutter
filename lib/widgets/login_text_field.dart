import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool hasAsterisks;
  const LoginTextField({Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.hasAsterisks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value){
        if(validator!=null) {
          return validator!(value);
        }
        return null;
      },
      obscureText: hasAsterisks? true : false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ThemeTextStyle.loginTextFieldStyle,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
