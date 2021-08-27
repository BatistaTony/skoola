import 'package:flutter/material.dart';

import 'package:skoola/components/buttonSocialNetwork.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/components/inputField.dart';
import 'package:skoola/components/outlinedButton.dart';
import 'package:skoola/components/passwordField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: size.height * 0.70,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 20 + size.height * 0.10),
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik-Bold',
                              fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: InputField(
                          placeholder: "Email",
                          inputOnchange: inputOnChangeEmail,
                        ),
                      ),
                      PasswordField(
                        inputOnChange: inputOnChangePassword,
                        isShowPassword: false,
                      )
                    ],
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: OutlinedButtonApp(
                    title: "Forgot Password ?",
                    press: forgetPassword,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ButtonApp(
                    title: "Login",
                    press: login,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 320,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Login with social networks",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color(0xffF8F5F1),
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  height: 1.3),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonSocialNetwork(
                              press: () => null,
                              icon: "facebook",
                            ),
                            ButtonSocialNetwork(
                              press: () => null,
                              icon: "instagram",
                            ),
                            ButtonSocialNetwork(
                              press: () => null,
                              icon: "google",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: OutlinedButtonApp(
                    title: "Sign up",
                    press: signUpPage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {}

  void signUpPage() {
    Navigator.pushNamed(context, "signup");
  }

  void forgetPassword() {}

  void inputOnChangeEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void inputOnChangePassword(String value) {
    setState(() {
      password = value;
    });
  }
}
