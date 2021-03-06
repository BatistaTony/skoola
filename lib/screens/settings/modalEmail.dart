import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:redux/redux.dart';
import 'package:skoola/components/inputField.dart';
import 'package:skoola/components/passwordField.dart';
import 'package:skoola/models/data.dart';
import 'package:skoola/components/modalSetting.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

class EmailSetting extends StatefulWidget {
  const EmailSetting({Key? key}) : super(key: key);

  @override
  _EmailSettingState createState() => _EmailSettingState();
}

class _EmailSettingState extends State<EmailSetting> {
  String email = "";
  String password = "";
  String erroTxt = "";
  String oldEmail = "";
  bool isLoading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => updateOldEmail(context));
  }

  void updateOldEmail(context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    setState(() {
      oldEmail = store.state.user!.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    UserEntity? userState = store.state.user;
    return ModalSetting(
      height: 0.55,
      isLoading: isLoading,
      onUpdate: () => updateEmail(context),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Update your email",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontFamily: 'Rubik-Medium',
                        fontSize: 16,
                      ),
                  textAlign: TextAlign.left,
                )),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: InputField(
                value: userState!.email,
                placeholder: "Email",
                isEnabled: true,
                inputOnchange: inputOnChangeOldEmail,
              ),
            ),
            PasswordField(
              inputOnChange: inputOnChangePassword,
              isEnabled: !isLoading,
              isShowPassword: false,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: InputField(
                value: "",
                placeholder: "New email",
                isEnabled: !isLoading,
                inputOnchange: inputOnChangeEmail,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: isLoading
                  ? Container(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                      child: erroTxt != ""
                          ? Text(
                              erroTxt,
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
            ),
          ],
        ),
      ],
    );
  }

  void inputOnChangeEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void inputOnChangeOldEmail(String value) {
    setState(() {
      oldEmail = value;
    });
  }

  void inputOnChangePassword(String value) {
    setErrorTxt("");

    setState(() {
      password = value;
    });
  }

  void setIsLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  void setErrorTxt(String txt) {
    setState(() {
      erroTxt = txt;
    });
  }

  Future<String> updateData() async {
    print("something to update here ..... ====> ");
    Store<AppState> store = StoreProvider.of<AppState>(context);
    var users = firebaseDb.collection("users");
    var userId = store.state.user?.id;
    var user = (await users.doc(userId).get());
    Map<String, dynamic> userObj = user.data() as Map<String, dynamic>;

    await users.doc(userId).set({
      "email": email,
      "avatar": "",
      "country": "",
      "name": userObj["name"]
    }).then((value) => print("sucessfully saved ! $email"));

    UserEntity userState =
        new UserEntity(user.id, "", "Angola", email, userObj["name"]);
    store.dispatch(SetUser(userState));

    return "sucess";
  }

  void updateEmail(dynamic context) async {
    if (email == "") return;

    setErrorTxt("");
    var emailIsValid = Fzregex.hasMatch(oldEmail, FzPattern.email);
    var passwordIsStrong = this.password.length > 5;

    if (emailIsValid && passwordIsStrong) {
      try {
        setIsLoading(true);
        var response = await firebaseAuth.signInWithEmailAndPassword(
            email: oldEmail, password: this.password);
        var isValidResp = response.user!.email;

        if (isValidResp != "" || isValidResp != null) {
          response.user?.updateEmail(email).then((value) {
            updateData().then((value) {
              if (value == "sucess") {
                Navigator.pop(context, false);
                setIsLoading(false);
              }
            });
          });
        }
      } on FirebaseAuthException catch (err) {
        print("the error occurred ===> $err");
        handError(err.code);
        setIsLoading(false);
      }
    } else {
      if (!emailIsValid) {
        setErrorTxt("Email is invalid ");
      } else if (!passwordIsStrong) {
        setErrorTxt("Password length must be greater tha 6");
      }
    }
  }

  void handError(String code) {
    print("the error code $code");

    if (code == "wrong-password") {
      setErrorTxt("User not found !");
    } else if (code == "too-many-requests") {
      setErrorTxt("Too many requests, try again later !");
    }
  }
}
