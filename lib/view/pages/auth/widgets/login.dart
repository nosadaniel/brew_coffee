import 'package:brew_coffee/constants/constant.dart';
import 'package:brew_coffee/controllers/app_controller.dart';
import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/view/pages/auth/widgets/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final AppController _appController = Get.put(AppController());
  final AuthController _authController = AuthController.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: TextFormField(
                  controller: _authController.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field must not be empty";
                    } else if (!EmailValidator.validate(value))
                      return "Invalid Email";
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: TextFormField(
                  controller: _authController.password,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: textInputDecoration.copyWith(
                    hintText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field must not be empty";
                    } else if (value.length < 6) {
                      return "Password should be more than six characters";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("success");
                    _authController.loginWithEmailPassword();
                  }
                },
                icon: Icon(Icons.login_outlined),
                label: Text("Login"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text("Don\'t have an account?"),
                    TextButton(
                      onPressed: () {
                        _appController.changeIsLoggedWidget();
                      },
                      child: Text("Signup",
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
