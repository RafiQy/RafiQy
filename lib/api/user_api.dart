import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafiqy/models/user_data.dart';

class UserApi {
  Future<bool> saveUserInfo(User user) async {
    var userDoc = await FirebaseFirestore.instance
        .collection('/users')
        .doc(user.uid)
        .get();
    if (!userDoc.exists) {
      userDoc.reference.set({
        "id": user.uid,
        "username": user.displayName ?? user.email.split('@').first,
        "photoUrl": user.photoURL,
        "email": user.email,
        "displayName": user.displayName ?? user.email.split('@').first,
        "bio": "",
        "timestamp": DateTime.now(),
        "isAdmin": false,
      });
      return true;
    }
    return false;
  }

  Future<UserData> getUserData(String id) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    if (userDoc != null) {
      return UserData.fromDocument(userDoc);
    }
    return null;
  }
}
