import 'package:skoola/models/data.dart';

class AppState {
  UserEntity? user;
  CourseEntity? course;

  AppState(this.user, this.course);

  AppState.fromAppState(AppState state) {
    user = state.user;
    course = state.course;
  }
}
