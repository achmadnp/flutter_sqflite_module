import 'package:flutter/cupertino.dart';
import 'package:flutter_sqflite_module/models/User.dart';

class Story {
  final String uid;
  final String title;
  final String body;
  final int userUid;
  final User user;

  Story({@required this.uid, this.title, this.body, this.userUid, this.user});

  static final columns = ['uid', 'title', 'body', 'userUid'];

  Map toMap() {
    Map map = {"uid": uid, "title": title, "body": body, "userUid": userUid};
    return map;
  }

  static fromMap(Map map) {
    Story story = Story(
        uid: map['uid'],
        title: map['title'],
        body: map['body'],
        userUid: map['userUid']);
  return story;
  }

}
