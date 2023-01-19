import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController? controllar;
  final TextInputType textInputType;
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  final EdgeInsetsGeometry padding;
  final Widget? suffixIcon;
  bool obscureText = false;
  final String? hintText;

  CustomTextForm({
    Key? key,
    required this.textInputType,
    required this.labelText,
    this.validator,
    this.onSave,
    required this.padding,
    this.controllar,
    this.suffixIcon,
    required this.obscureText,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controllar,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.headline5,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
        onSaved: onSave,
      ),
    );
  }
}
