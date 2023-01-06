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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final name = useState("");
    final email = useState("");
    final password = useState("");
    final repassword = useState("");
    final animate = useState(false);
    final success = useState<bool?>(null);

    onSignUp(context) async {
      animate.value = true;
      bool isValidate = await Future.delayed(
        const Duration(milliseconds: 100),
        () => formKey.currentState!.validate(),
      );
      if (!isValidate) {
        animate.value = false;
        success.value = false;
        await Future.delayed(
          const Duration(milliseconds: 100),
          () => success.value = null,
        );
        return;
      }
      animate.value = false;
      success.value = await register(
        context,
        name: name.value,
        email: email.value,
        password: password.value,
      );

      ///TODO: Register Successful Show Alert Information
    }

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
                    } else if (val != repassword.value) {
                      return 'Passwords doesn\'t match';
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
                    } else if (val != password.value) {
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
                      child: InkWell(
                        onTap: () => onSignUp(context),
                        child: PrimaryButton(
                          text: "SignUp",
                          shouldAnimate: animate.value,
                          isSuccess: success.value,
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
