import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/Enterance/Page/Components/custom_textformfield.dart';
import 'package:geo_app/Page/Enterance/Page/Components/primary_button.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';

class SignupForm extends HookWidget with EnteranceInteraction {
  SignupForm({
    Key? key,
    required this.onHaveAccount,
  }) : super(key: key);
  final Function() onHaveAccount;
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final repassword = useTextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            CustomTextFormField(
              controller: name,
              keyboardType: TextInputType.name,
              labelText: "Name",
              hintText: "Enter your name here...",
              isPassword: false,
              validatorFunc: (val) {
                if (val!.isEmpty) {
                  return 'Please enter your name';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              labelText: "Email",
              hintText: "Enter your email here...",
              isPassword: false,
              validatorFunc: (val) {
                if (val!.isEmpty) {
                  return 'Please enter your email adress';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              labelText: "Password",
              hintText: "Enter your password here...",
              isPassword: true,
              validatorFunc: (val) {
                if (val!.isEmpty) {
                  return 'Please enter your password';
                } else if (val != repassword.text) {
                  return 'Passwords doesn\'t match';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              controller: repassword,
              keyboardType: TextInputType.visiblePassword,
              labelText: "Confirm Password",
              hintText: "Re-Enter your password here...",
              isPassword: true,
              validatorFunc: (val) {
                if (val!.isEmpty) {
                  return 'Please enter your repassword';
                } else if (val != password.text) {
                  return 'Passwords doesn\'t match';
                } else {
                  return null;
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: onHaveAccount,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        "Have an account?\nLogin",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PrimaryButton(
                    text: "SignUp",
                    onTap: () async => await register(
                      context,
                      name: name.text,
                      email: email.text,
                      password: password.text,
                    ),
                    validate: () => formKey.currentState!.validate(),
                  ),
                ),
              ],
            ),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
