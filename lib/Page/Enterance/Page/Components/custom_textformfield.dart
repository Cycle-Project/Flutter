import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class CustomTextFormField extends HookWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.isPassword = false,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.showBorder = true,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool isPassword;
  final Function(String?) validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);
    final border = showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Constants.darkBluishGreyColor),
          )
        : const OutlineInputBorder(borderSide: BorderSide.none);
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
      validator: (val) => validator(val),
      obscureText: isPassword ? obscureText.value : false,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
