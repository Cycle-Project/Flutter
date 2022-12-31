import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/Enterance/Page/Components/custom_textformfield.dart';
import 'package:geo_app/Page/Enterance/Page/Components/string_extension.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class LoginForm extends HookWidget with EnteranceInteraction {
  LoginForm({
    Key? key,
    required this.onDontHaveAccount,
  }) : super(key: key);
  final Function() onDontHaveAccount;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final email = useState("");
    final password = useState("");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: ThemeData(primaryColor: Colors.black),
        child: FormField(
          builder: (state) => Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  onChangedFunction: (val) => email.value = val,
                  labelText: "Email Address",
                  hintText: "Enter your email here...",
                  isPassword: false,
                  validatorFunc: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter your email';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextFormField(
                  onChangedFunction: (val) => password.value = val,
                  labelText: "Password",
                  hintText: "Enter your password here...",
                  isPassword: true,
                  validatorFunc: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter your password';
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
                        onTap: onDontHaveAccount,
                        child: const SizedBox(
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Text(
                              "Don't have an account?\nCreate Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          if (!formKey.currentState!.validate()) return;
                          await login(
                            context,
                            email: email.value,
                            password: password.value,
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}