import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/GPS/location_service.dart';
import 'package:geo_app/Page/Enterance/Page/login_form.dart';
import 'package:geo_app/Page/Enterance/Page/signup_form.dart';

class LoginOrSignUpPage extends HookWidget {
  const LoginOrSignUpPage({Key? key}) : super(key: key);

  login(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LocationService(),
      ),
      (r) => r.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = useState(true);
    return Wrap(
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
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        isLogin.value
            ? LoginForm(
                onLogin: () => login(context),
                onDontHaveAccount: () => isLogin.value = false,
              )
            : SignupForm(
                onSignup: () => isLogin.value = true,
                onHaveAccount: () => isLogin.value = true,
              ),
        if (isLogin.value)
          SizedBox(
            height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {},
                  child: const Text(
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
