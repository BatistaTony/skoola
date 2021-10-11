import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SetUser) {
    newState.user = action.payload;
  }

  return newState;
}
