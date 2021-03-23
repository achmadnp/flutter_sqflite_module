import 'package:flutter/cupertino.dart';

class User {
  final String uid;

  final String username;

  User({@required this.uid, this.username});

  static final columns = ['uid', 'username'];

  Map toMap() {
    Map map = {"username": username, "uid": uid};
    return map;
  }

  static fromMap(Map map) {
    User user = User(uid: map['uid'], username: map['username']);
    return user;
  }
}
