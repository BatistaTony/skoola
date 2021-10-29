import 'package:skoola/models/data.dart';
import 'package:skoola/store/actions/course.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SetUser) {
    newState.user = action.payload;
  } else if (action is LogOut) {
    newState.user = new UserEntity("", "", "", "", "");
  } else if (action is SetCourse) {
    newState.course = action.payload;
  }
  return newState;
}
