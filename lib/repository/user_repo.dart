import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafiqy/api/user_api.dart';
import 'package:rafiqy/models/user_data.dart';

class UserRepo {
  Future<bool> saveUserFromRepo(User user) async {
    return await UserApi().saveUserInfo(user);
  }

  Future<UserData> getUserFromRepo(String id) async {
    return await UserApi().getUserData(id);
  }
}
