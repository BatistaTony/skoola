import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skoola/components/buttonSocialNetwork.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/components/inputField.dart';
import 'package:skoola/components/outlinedButton.dart';
import 'package:skoola/components/passwordField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:skoola/models/data.dart';
import 'package:skoola/screens/home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  String name = "";
  String email = "";
  String password = "";
  ErrorType errorForm = ErrorType(false, "", "");
  bool isLoading = false;

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
                            isEnabled: !isLoading,
                            inputOnchange: inputOnChangeName,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: InputField(
                            placeholder: "Email",
                            isEnabled: !isLoading,
                            inputOnchange: inputOnChangeEmail,
                          ),
                        ),
                        PasswordField(
                          inputOnChange: inputOnChangePassword,
                          isEnabled: !isLoading,
                          isShowPassword: true,
                        )
                      ],
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: errorForm.status
                          ? Text(
                              errorForm.msg,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.red,
                                    fontFamily: 'Rubik-Medium',
                                    fontSize: 15,
                                  ),
                              textAlign: TextAlign.center,
                            )
                          : Container()),
                  Container(
                    child: isLoading
                        ? Container(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: ButtonApp(
                      title: "Sign up",
                      press: isLoading ? () => null : signup,
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
                      press: isLoading ? () => null : loginPage,
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
    setIsError(false, "", "");

    Navigator.pushNamed(context, "login");
  }

  void signup() async {
    setIsError(false, "", "");

    CollectionReference<Map<String, dynamic>> usersCollection =
        firebaseDb.collection("users");

    var emailIsValid = Fzregex.hasMatch(this.email, FzPattern.email);
    var passwordIsStrong = this.password.length > 6;
    var nameIsStrong = this.name.length > 5;

    if (emailIsValid && passwordIsStrong && nameIsStrong) {
      try {
        setIsLoading(true);
        var response = await auth.createUserWithEmailAndPassword(
            email: this.email, password: this.password);
        var isValidResp = response.user!.email;

        if (isValidResp != "" || isValidResp != null) {
          usersCollection.doc(this.email).set({"name": this.name});
          setIsLoading(false);
          goToHome();
        }
      } on FirebaseAuthException catch (err) {
        setIsLoading(false);
        handleCodeError(err.code);
      }
    } else {
      if (!nameIsStrong) {
        setIsError(true, "name", "Name length must be greater tha 5");
      } else if (!emailIsValid) {
        setIsError(true, "email", "Nmail is invalid ");
      } else if (!passwordIsStrong) {
        setIsError(true, "password", "Password length must be greater tha 6");
      }
    }
  }

  void goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (route) => false,
    );
  }

  void setIsLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  void setIsError(bool status, String field, String msg) {
    setIsLoading(false);

    setState(() {
      errorForm.status = status;
      errorForm.msg = msg;
      errorForm.field = field;
    });
  }

  void handleCodeError(String code) {
    if (code == "email-already-exists" || code == "email-already-in-use") {
      setIsError(true, "email",
          "The email address is already in use by another account.");
    } else if (code == "auth/invalid-password") {
      setIsError(true, "email",
          "The email address is already in use by another account.");
    } else if (code.length > 0) {
      setIsError(true, "", "There something wrong, try again !");
    }
  }

  void inputOnChangeEmail(String value) {
    if (errorForm.field == "email") {
      setIsError(false, "", "");
    }

    setState(() {
      email = value;
    });
  }

  void inputOnChangeName(String value) {
    if (errorForm.field == "name") {
      setIsError(false, "", "");
    }

    setState(() {
      name = value;
    });
  }

  void inputOnChangePassword(String value) {
    if (errorForm.field == "password") {
      setIsError(false, "", "");
    }
    setState(() {
      password = value;
    });
  }
}
