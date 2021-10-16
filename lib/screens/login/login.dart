import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:redux/redux.dart';
import 'package:skoola/components/buttonSocialNetwork.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/components/inputField.dart';
import 'package:skoola/components/outlinedButton.dart';
import 'package:skoola/components/passwordField.dart';
import 'package:skoola/models/data.dart';
import 'package:skoola/screens/home/home.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  String email = "";
  String password = "";
  ErrorType errorForm = ErrorType(false, "", "");
  bool isLoading = false;

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
        child: SizedBox(
          height: size.height * 0.85,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.only(bottom: size.height > 800.0 ? 25 : 5),
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
                            isEnabled: !isLoading,
                            inputOnchange: inputOnChangeEmail,
                          ),
                        ),
                        PasswordField(
                          inputOnChange: inputOnChangePassword,
                          isEnabled: !isLoading,
                          isShowPassword: false,
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
                      press: isLoading ? () => null : login,
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
      ),
    );
  }

  void login() async {
    setIsError(false, "", "");
    Store<AppState> store = StoreProvider.of<AppState>(context);
    var users = firebaseDb.collection("users");

    var emailIsValid = Fzregex.hasMatch(this.email, FzPattern.email);
    var passwordIsStrong = this.password.length >= 6;

    if (emailIsValid && passwordIsStrong) {
      try {
        setIsLoading(true);

        var response = await auth.signInWithEmailAndPassword(
            email: this.email, password: this.password);
        var isValidResp = response.user!.email;

        if (isValidResp != "" || isValidResp != null) {
          setIsLoading(false);
          var userId = response.user!.uid;

          var user = (await users.doc(userId).get());
          Map<String, dynamic> userObj = user.data() as Map<String, dynamic>;

          UserEntity userState = new UserEntity(
              userId, "", user["country"], this.email, userObj["name"]);
          store.dispatch(SetUser(userState));
          goToHome();
        }
      } on FirebaseAuthException catch (err) {
        setIsLoading(false);
        handleCodeError(err.code);
      }
    } else {
      if (!emailIsValid) {
        setIsError(true, "email", "Email is invalid ");
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

  void signUpPage() {
    Navigator.pushNamed(context, "signup");
  }

  void forgetPassword() {}

  void inputOnChangeEmail(String value) {
    if (errorForm.field == "email") {
      setIsError(false, "", "");
    }

    setState(() {
      email = value;
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

  void setIsLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  void handleCodeError(String code) {
    if (code == "email-already-exists" || code == "email-already-in-use") {
      setIsError(true, "email",
          "The email address is already in use by another account.");
    } else if (code == "wrong-password") {
      setIsError(true, "password", "wrong password");
    } else if (code == "user-not-found") {
      setIsError(true, "", "User not found !");
    } else if (code.length > 0) {
      print(code);
      setIsError(true, "", "There something wrong, try again !");
    }
  }

  void setIsError(bool status, String field, String msg) {
    setIsLoading(false);

    setState(() {
      errorForm.status = status;
      errorForm.msg = msg;
      errorForm.field = field;
    });
  }
}
