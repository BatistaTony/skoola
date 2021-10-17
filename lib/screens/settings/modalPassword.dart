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
import 'package:skoola/store/app_state.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({Key? key}) : super(key: key);

  @override
  _PasswordSettingState createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
  String email = "";
  String newPassword = "";
  String oldPassword = "";

  String erroTxt = "";
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
      email = store.state.user!.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    UserEntity? userState = store.state.user;
    return ModalSetting(
      height: 0.55,
      isLoading: isLoading,
      onUpdate: () => updatePassword(context),
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
                placeholder: "old",
                isEnabled: true,
                inputOnchange: inputOnChangeEmail,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: PasswordField(
                placeholder: "Old password",
                inputOnChange: inputOnChangeOldPassword,
                isEnabled: !isLoading,
                isShowPassword: false,
              ),
            ),
            PasswordField(
              placeholder: "New password",
              inputOnChange: inputOnChangeNewPassword,
              isEnabled: !isLoading,
              isShowPassword: false,
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

  void inputOnChangeOldPassword(String value) {
    setErrorTxt("");

    setState(() {
      oldPassword = value;
    });
  }

  void inputOnChangeNewPassword(String value) {
    setErrorTxt("");

    setState(() {
      newPassword = value;
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

  void updatePassword(dynamic context) async {
    setIsLoading(false);
    setErrorTxt("");
    var emailIsValid = Fzregex.hasMatch(email, FzPattern.email);
    var passwordIsStrong = this.oldPassword.length > 5;
    var newPasswordIsStrong = this.newPassword.length > 5;

    if (emailIsValid && passwordIsStrong && newPasswordIsStrong) {
      try {
        setIsLoading(true);
        var response = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: this.oldPassword);
        var isValidResp = response.user!.email;

        if (isValidResp != "" || isValidResp != null) {
          response.user?.updatePassword(newPassword).then((value) {
            Navigator.pop(context, false);
            setIsLoading(false);
          });
        }
      } on FirebaseAuthException catch (err) {
        print(err.credential);
        setErrorTxt("something went wrong, try again");
        setIsLoading(false);
      }
    } else {
      if (!emailIsValid) {
        setErrorTxt("Email is invalid ");
      } else if (!passwordIsStrong) {
        setErrorTxt("Old password length must be greater tha 6");
      } else if (!newPasswordIsStrong) {
        setErrorTxt("New password length must be greater tha 6");
      }
    }
  }
}
