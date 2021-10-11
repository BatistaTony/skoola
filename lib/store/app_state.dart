import 'package:skoola/models/data.dart';

class AppState {
  UserEntity? user;

  AppState(this.user);

  AppState.fromAppState(AppState state) {
    user = state.user;
  }
}
