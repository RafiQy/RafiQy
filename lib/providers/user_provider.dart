import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiqy/models/user_data.dart';
import 'package:rafiqy/repository/user_repo.dart';

class UserProvider with ChangeNotifier {
  UserData _user;

  Future<bool> saveUserInfo(User user) async {
    var isSaved = await UserRepo().saveUserFromRepo(user);
    return isSaved;
  }

  UserData get user => _user;

  getUserInfo(String id) async {
    _user = await UserRepo().getUserFromRepo(id);
    notifyListeners();
  }
}
