import 'package:brew_coffee/constants/constant.dart';
import 'package:brew_coffee/controllers/app_controller.dart';
import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final AppController _appController = Get.put(AppController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 250, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.brown.withOpacity(.7))),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: TextFormField(
                controller: _authController.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field must not be empty";
                  } else if (!EmailValidator.validate(value))
                    return "Invalid Email";
                  else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (String value) =>
                    EmailValidator.validate(value) ? null : "Email is Invalid",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: TextFormField(
                controller: _authController.password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field must not be empty";
                  } else if (value.length < 6) {
                    return "Password should be more than six characters";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: textInputDecoration.copyWith(
                  hintText: "Password",
                ),
              ),
            ),
            AuthButton(formKey: _formKey, authController: _authController),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text("Already Register?"),
                  TextButton(
                    onPressed: () {
                      _appController.changeIsLoggedWidget();
                    },
                    child: Text("Login",
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required AuthController authController,
  })  : _formKey = formKey,
        _authController = authController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final AuthController _authController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          print("success");
          _authController.signupWithEmailPassword(
              _authController.email, _authController.password);
        }
      },
      icon: Icon(Icons.login_outlined),
      label: Text("Signup"),
    );
  }
}
