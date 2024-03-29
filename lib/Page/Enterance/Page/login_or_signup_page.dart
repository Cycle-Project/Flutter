import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/Enterance/Page/login_form.dart';
import 'package:geo_app/Page/Enterance/Page/signup_form.dart';
import 'package:geo_app/Page/Enterance/enterance_interaction.dart';

class LoginOrSignUpPage extends HookWidget with EnteranceInteraction {
  LoginOrSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLogin = useState(true);
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isLogin.value ? "Welcome!" : "Create Account",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 12),
              child: Text(
                isLogin.value
                    ? "To the future of transportation"
                    : "To enter the newest cycling world",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        isLogin.value
            ? LoginForm(onDontHaveAccount: () => isLogin.value = false)
            : SignupForm(onHaveAccount: () => isLogin.value = true),
        if (isLogin.value)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () => forgetPassword(context),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
