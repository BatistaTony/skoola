import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skoola/components/buttonSocialNetwork.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/components/inputField.dart';
import 'package:skoola/components/outlinedButton.dart';
import 'package:skoola/components/passwordField.dart';
import 'package:skoola/screens/home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          onPressed: loginPage,
          icon: Container(
            width: 23,
            height: 23,
            child: SvgPicture.asset(
              "assets/icons/back.svg",
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height > 800.0 ? size.height * 0.85 : size.height * 0.90,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.only(bottom: size.height > 800.0 ? 25 : 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin:
                          EdgeInsets.only(bottom: size.height > 800.0 ? 20 : 0),
                      child: Image.asset("assets/images/logo.png")),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15, bottom: 5),
                          width: 200,
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik-SemiBold',
                                fontSize: 24),
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
                          margin: EdgeInsets.only(bottom: 20),
                          child: InputField(
                            placeholder: "Name",
                            inputOnchange: inputOnChangeName,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: InputField(
                            placeholder: "Email",
                            inputOnchange: inputOnChangeEmail,
                          ),
                        ),
                        PasswordField(
                          inputOnChange: inputOnChangePassword,
                          isShowPassword: true,
                        )
                      ],
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ButtonApp(
                      title: "Sign up",
                      press: signup,
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
                            "Sign up with social networks",
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
                    margin: EdgeInsets.only(top: 15),
                    child: OutlinedButtonApp(
                      title: "Login",
                      press: loginPage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginPage() {
    Navigator.pushNamed(context, "login");
  }

  void signup() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (route) => false,
    );
  }

  void forgetPassword() {}

  void inputOnChangeEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void inputOnChangeName(String value) {
    setState(() {
      name = value;
    });
  }

  void inputOnChangePassword(String value) {
    setState(() {
      password = value;
    });
  }
}
