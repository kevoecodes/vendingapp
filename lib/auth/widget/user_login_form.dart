import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vendingapp/Home/presentation/home.dart';
import 'package:vendingapp/auth/presentation/signup.dart';
import 'package:vendingapp/model/user.dart';
import 'package:vendingapp/utils/api/api.dart';
import 'package:vendingapp/utils/snack.dart';

class RegistrationForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  RegistrationForm(
      {required this.usernameController,
      required this.passwordController,
      super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  errorStyle: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w400),
                  floatingLabelStyle: const TextStyle(color: Color(0xff176B87)),
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Color(0xff176B87),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  isDense: true,
                  constraints:
                      const BoxConstraints(maxHeight: 70, minHeight: 50),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff176B87)),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff176B87)),
                      borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username required";
                  }
                  if (usernameController.text.length != 10) {
                    return "Please use valid phone number";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorStyle: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w400),
                  floatingLabelStyle: const TextStyle(color: Color(0xff176B87)),
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xff176B87),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  isDense: true,
                  constraints:
                      const BoxConstraints(maxHeight: 70, minHeight: 50),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff176B87)),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff176B87)),
                      borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password required";
                  }
                  if (passwordController.text.length < 5) {
                    return 'Password is too short';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  const Text(
                    'Don\'t have account?',
                    style: TextStyle(
                      color: Color(0xff176B87),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const SignuPage())); //Navigate to the singnup page
                      },
                      child: const Text('Signup',
                          style: TextStyle(
                              color: Color(0xff176B87),
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                  height: 50,
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      validatForm(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff176B87)),
                    child: const Text(
                      'Signin',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
          ],
        ));
  }

  //Form validation function
  void validatForm(BuildContext context) async {
    String message;
    if (formKey.currentState!.validate()) {
      var res = await CallApi().postRequest(
          {'password': passwordController}, 'api/v1/auth/login',
          context: context);
      if (res != null) {
        if (res.statusCode == 200) {
          var body = json.decode(res.body);

          User.login(context, body['token'], body['user']);

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomePage()));

          message = 'Successfully logged!';
          showSnack(context, message);
        }
      }
      message = 'Oooops try again!';
      showSnack(context, message);
      // Navigator.of(context);
    } else {
      message = 'Oooops try again!';
      showSnack(context, message);
    }
  }
}
