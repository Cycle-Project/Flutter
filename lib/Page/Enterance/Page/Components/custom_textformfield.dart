import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class CustomTextFormField extends HookWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.validatorFunc,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final bool isPassword;
  final Function(String?) validatorFunc;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Constants.darkBluishGreyColor),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        color: Colors.red.shade600,
      ),
    );
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Constants.darkBluishGreyColor),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: errorBorder,
        suffixIcon: isPassword
            ? IconButton(
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Constants.darkBluishGreyColor,
                ),
                onPressed: () => obscureText.value = !obscureText.value,
              )
            : null,
      ),
      validator: (val) => validatorFunc(val),
      obscureText: isPassword ? obscureText.value : false,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      maxLines: 1,
    );
  }
}
