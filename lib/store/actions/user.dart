import 'package:skoola/models/data.dart';
import 'package:skoola/store/app_state.dart';

class SetUser {
  final UserEntity payload;
  SetUser(this.payload);
}

class LogOut {}
