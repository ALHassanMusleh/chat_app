import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.hintText,
      this.labelText,
      this.onChanged,
      this.obscureText = false});

  Function(String)? onChanged;
  String? hintText;
  String? labelText;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required'; //error message show
        }
        // else if(!data.contains('@')){
        //   return 'Email required contain @';
        // }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          color: Colors.grey[300],
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
