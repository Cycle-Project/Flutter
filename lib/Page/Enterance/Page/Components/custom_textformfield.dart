import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class CustomTextFormField extends HookWidget {
  const CustomTextFormField({
    Key? key,
    required this.onChangedFunction,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.validatorFunc,
  }) : super(key: key);

  final Function(String)? onChangedFunction;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final Function(String?) validatorFunc;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Constants.darkBluishGreyColor),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        color: Colors.red.shade600,
      ),
    );
    final obscureText = useState(true);
    return TextFormField(
      onChanged: onChangedFunction,
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
            : const SizedBox(),
      ),
      validator: (val) => validatorFunc(val),
      obscureText: isPassword ? obscureText.value : false,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      maxLines: 1,
    );
  }
}
