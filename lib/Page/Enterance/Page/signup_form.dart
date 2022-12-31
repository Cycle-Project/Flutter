import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Page/Enterance/Page/Components/custom_textformfield.dart';
import 'package:geo_app/Page/Enterance/Page/Components/string_extension.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class SignupForm extends HookWidget with EnteranceInteraction {
  SignupForm({
    Key? key,
    required this.onHaveAccount,
    required this.voidCallback,
  }) : super(key: key);
  final Function() onHaveAccount;
  final formKey = GlobalKey<FormState>();
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    final name = useState("");
    final email = useState("");
    final password = useState("");
    final repassword = useState("");

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
                  onChangedFunction: (val) => name.value = val,
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
                  onChangedFunction: (val) => email.value = val,
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
                CustomTextFormField(
                  onChangedFunction: (val) => repassword.value = val,
                  labelText: "Confirm Password",
                  hintText: "Re-Enter your password here...",
                  isPassword: true,
                  validatorFunc: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter your repassword';
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
                        child: const SizedBox(
                          height: 50,
                          child: Padding(
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
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          if (!formKey.currentState!.validate()) return;
                          if (password.value != repassword.value) return;
                          await register(
                            name: name.value,
                            email: email.value,
                            password: password.value,
                          ).then((_) => voidCallback);

                          ///TODO: Register Successful Show Alert Information
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "SignUp",
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