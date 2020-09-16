import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;
  final bool isAdmin;

  UserData({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
    this.isAdmin,
  });

  factory UserData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    return UserData(
        id: data['id'],
        username: data["username"],
        email: data["email"],
        photoUrl: data["photoUrl"],
        displayName: data["displayName"],
        bio: data["bio"],
        isAdmin: data["isAdmin"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'bio': bio,
      'isAdmin': isAdmin,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserData(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      displayName: map['displayName'],
      bio: map['bio'],
      isAdmin: map['isAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));
}
