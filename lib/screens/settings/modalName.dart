import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:skoola/components/inputField.dart';
import 'package:skoola/models/data.dart';
import 'package:skoola/screens/settings/modalSetting.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

class NameSetting extends StatefulWidget {
  const NameSetting({Key? key}) : super(key: key);

  @override
  _NameSettingState createState() => _NameSettingState();
}

class _NameSettingState extends State<NameSetting> {
  String name = "";
  String erroTxt = "";
  bool isLoading = false;
  FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    UserEntity? userState = store.state.user;
    return ModalSetting(
      isLoading: isLoading,
      onUpdate: () => updateName(userState!.email ?? "", context),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Update your name",
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
                value: userState!.name,
                placeholder: "Name",
                isEnabled: !isLoading,
                inputOnchange: inputOnChangeName,
              ),
            ),
            Container(
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

  void inputOnChangeName(String value) {
    setState(() {
      name = value;
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

  void updateName(String userId, dynamic context) async {
    if (name == "") return;
    try {
      setIsLoading(true);
      print(userId);
      Store<AppState> store = StoreProvider.of<AppState>(context);

      CollectionReference<Map<String, dynamic>> users =
          firebaseDb.collection("users");
      var response = await users.doc(userId).get();
      Map<String, dynamic> user = response.data() as Map<String, dynamic>;
      var newUser = user;
      newUser["name"] = name;
      await users.doc(userId).set(newUser).then((value) {
        UserEntity userState = new UserEntity(
            response.id, "", "Angola", response.id, newUser["name"]);
        store.dispatch(SetUser(userState));
        Navigator.pop(context, false);
        setIsLoading(false);
      }).catchError((onError) {
        setIsLoading(false);
      });
    } on FirebaseException catch (err) {
      setIsLoading(false);
      setErrorTxt("Something went wrong, try again");
      print(err);
    }
  }
}
