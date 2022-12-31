import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextFormField extends HookWidget {
  CustomTextFormField({
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
    final obscureText = useState(true);
    return TextFormField(
      onChanged: onChangedFunction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword ? IconButton(
          icon: const Icon(
            Icons.remove_red_eye_outlined,
            color: Colors.black,
          ),
          onPressed: () => obscureText.value = !obscureText.value,
        ) : const SizedBox(),
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