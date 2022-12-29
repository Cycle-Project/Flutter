import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Client/IClient.dart';
import 'package:geo_app/Client/Models/user_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class SignupForm extends HookWidget {
  SignupForm({
    Key? key,
    required this.onSignup,
    required this.onHaveAccount,
  }) : super(key: key);
  final Function() onSignup;
  final Function() onHaveAccount;

  IClient _client = Client();
  UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    final name = useState("");
    final email = useState("");
    final password = useState("");
    final repassword = useState("");
    final obscureText1 = useState(true);
    final obscureText2 = useState(true);

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
                onChanged: (val) => name.value = val,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name here...",
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
                    onTap: () => obscureText1.value = !obscureText1.value,
                  ),
                ),
                obscureText: obscureText1.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                maxLines: 1,
              ),
              TextField(
                onChanged: (val) => repassword.value = val,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Re-Enter your password here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: InkWell(
                    child: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.black,
                    ),
                    onTap: () => obscureText2.value = !obscureText2.value,
                  ),
                ),
                obscureText: obscureText2.value,
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
                      onTap: () {
                        _userModel = UserModel(
                          name: name.value,
                          email: email.value,
                          password: password.value,
                        );
                        _client.registerUser(
                          userModel: _userModel,
                        );
                        List<UserModel> users = _client.getHttpUserModel() as List<UserModel>;
                        print(users);
                        print(_userModel.name);
                        onSignup();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
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
    );
  }
}
