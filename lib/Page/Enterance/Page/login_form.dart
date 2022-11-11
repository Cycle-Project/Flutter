import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class LoginForm extends HookWidget {
  const LoginForm({
    Key? key,
    required this.onLogin,
    required this.onDontHaveAccount,
  }) : super(key: key);
  final Function() onLogin;
  final Function() onDontHaveAccount;

  @override
  Widget build(BuildContext context) {
    final email = useState("");
    final password = useState("");
    final obscureText = useState(true);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: ThemeData(primaryColor: Colors.black),
        child: FormField(
          builder: (state) => Column(
            children: [
              TextField(
                onChanged: (val) => email.value = val,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter your email here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                maxLines: 1,
              ),
              TextField(
                onChanged: (val) => password.value = val,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: InkWell(
                    child: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.black,
                    ),
                    onTap: () => obscureText.value = !obscureText.value,
                  ),
                ),
                obscureText: obscureText.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                maxLines: 1,
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
                      onTap: onLogin,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
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
    );
  }
}
