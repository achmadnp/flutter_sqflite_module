import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_sqflite_module/repos/DatabaseHelper.dart';
import 'package:flutter_sqflite_module/repos/StoryDatabaseHelper.dart';
import 'package:flutter_sqflite_module/repos/UserDatabaseHelper.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQFlite module demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  final userDbHelper = UserDatabaseHelper.instance;
  final storyDbHelper = StoryDatabaseHelper.instance;

  String userInsertDataUidString = '';
  String userInsertDataUsernameString = '';
  final userInsertDataUid = TextEditingController();
  final userInsertDataUsername = TextEditingController();

  String userUpdateDataUidString = '';
  String userUpdateDataUsernameString = '';
  final userUpdateDataUid = TextEditingController();
  final userUpdateDataNewUsername = TextEditingController();

  String userDeleteDataUidString = '';
  final userDeleteDataUid = TextEditingController();

  List userDatas = [];

  String storyInsertDataStoryUidString = '';
  String storyInsertDataTitleString = '';
  String storyInsertDataBodyString = '';
  String storyInsertDataUserUidString = '';
  final storyInsertDataStoryUid = TextEditingController();
  final storyInsertDataTitle = TextEditingController();
  final storyInsertDataBody = TextEditingController();
  final storyInsertDataUserUid = TextEditingController();

  String storyUpdateDataStoryUidString = '';
  String storyUpdateDataTitleString = '';
  String storyUpdateDataBodyString = '';
  final storyUpdateDataStoryUid = TextEditingController();
  final storyUpdateDataTitle = TextEditingController();
  final storyUpdateDataBody = TextEditingController();

  String storyDeleteDataStoryUidString = '';
  final storyDeleteDataStoryUid = TextEditingController();

  List storyDatas = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('sqflite'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_box_rounded)),
              Tab(icon: Icon(Icons.image)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: userInsertDataUid,
                              decoration:
                                  InputDecoration(helperText: 'USER UID'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: userInsertDataUsername,
                              decoration:
                                  InputDecoration(helperText: 'USERNAME'),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                userInsertDataUidString =
                                    userInsertDataUid.text;
                                userInsertDataUsernameString =
                                    userInsertDataUsername.text;
                              });

                              _insertUser(userInsertDataUidString,
                                  userInsertDataUsernameString);
                            },
                            child: Text('insert data')),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: userUpdateDataUid,
                              decoration:
                                  InputDecoration(helperText: 'USER UID'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: userUpdateDataNewUsername,
                              decoration:
                                  InputDecoration(helperText: 'NEW USERNAME'),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                userUpdateDataUidString =
                                    userUpdateDataUid.text;
                                userUpdateDataUsernameString =
                                    userUpdateDataNewUsername.text;
                              });

                              _updateUser(userUpdateDataUidString,
                                  userUpdateDataUsernameString);
                            },
                            child: Text('update data')),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: userDeleteDataUid,
                              decoration:
                                  InputDecoration(helperText: 'USER UID'),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                userDeleteDataUidString =
                                    userDeleteDataUid.text;
                              });

                              _deleteUser(userDeleteDataUidString);
                            },
                            child: Text('delete data')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: ElevatedButton(
                              onPressed: () {
                                _queryUser();
                              },
                              child: Text('query data')),
                        ),
                      ],
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: userDatas.length != 0
                            ? ListView.builder(
                                itemCount: userDatas.length,
                                itemBuilder: (BuildContext context, int index) {
                                  print(userDatas.length);
                                  return Text(userDatas[index].toString());
                                })
                            : Text('No Query')),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyInsertDataStoryUid,
                              decoration:
                                  InputDecoration(helperText: 'STORYUID'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyInsertDataTitle,
                              decoration: InputDecoration(helperText: 'TITLE'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyInsertDataBody,
                              decoration: InputDecoration(helperText: 'BODY'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyInsertDataUserUid,
                              decoration:
                                  InputDecoration(helperText: 'userUID'),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                storyInsertDataStoryUidString =
                                    storyInsertDataStoryUid.text;
                                storyInsertDataTitleString =
                                    storyInsertDataTitle.text;
                                storyInsertDataBodyString =
                                    storyInsertDataBody.text;
                                storyInsertDataUserUidString =
                                    storyInsertDataBody.text;
                              });

                              _insertStory(
                                  storyInsertDataStoryUidString,
                                  storyInsertDataTitleString,
                                  storyInsertDataBodyString,
                                  storyInsertDataUserUidString);
                            },
                            child: Text('insert\ndata')),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4.2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyUpdateDataStoryUid,
                              decoration:
                                  InputDecoration(helperText: 'STORYUID'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyUpdateDataTitle,
                              decoration: InputDecoration(helperText: 'TITLE'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyUpdateDataBody,
                              decoration: InputDecoration(helperText: 'BODY'),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                storyUpdateDataStoryUidString =
                                    storyUpdateDataStoryUid.text;
                                storyUpdateDataTitleString =
                                    storyUpdateDataTitle.text;
                                storyUpdateDataBodyString =
                                    storyUpdateDataBody.text;
                              });

                              _updateStory(
                                  storyUpdateDataStoryUidString,
                                  storyUpdateDataTitleString,
                                  storyUpdateDataBodyString);
                            },
                            child: Text('update data')),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: storyDeleteDataStoryUid,
                              decoration:
                                  InputDecoration(helperText: 'STORYUID'),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                storyDeleteDataStoryUidString =
                                    storyDeleteDataStoryUid.text;
                              });

                              _deleteStory(storyDeleteDataStoryUidString);
                            },
                            child: Text('delete data')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: ElevatedButton(
                              onPressed: () {
                                _queryStory();
                              },
                              child: Text('query data')),
                        ),
                      ],
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: storyDatas.length != 0
                            ? ListView.builder(
                                itemCount: storyDatas.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(storyDatas[index].toString());
                                })
                            : Text('No Story Query')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertUser(String userUID, String username) async {
    // row to insert
    Map<String, dynamic> row = {
      UserDatabaseHelper.columnUid: '$userUID',
      UserDatabaseHelper.columnUsername: '$username',
    };
    final id = await userDbHelper.insertUserData(row);
    print('added row id : $id');
  }

  void _queryUser() async {
    final userAllRows = await userDbHelper.querryAllUserData();
    print('query all rows: ');
    setState(() {
      userDatas.clear();
    });
    userAllRows.forEach((element) {
      setState(() {
        userDatas.add(element);
      });
      print('$userDatas');
    });
  }

  void _updateUser(String userId, String username) async {
    // row to update
    Map<String, dynamic> row = {
      UserDatabaseHelper.columnUid: userId,
      UserDatabaseHelper.columnUsername: username
    };
    final rowsAffected = await userDbHelper.updateUserData(row);
    print('updated $rowsAffected row(s)');
  }

  void _deleteUser(String uid) async {
    // Assuming that the number of rows is the id for the last row.
    final id = await userDbHelper.queryRowCount();
    final rowsDeleted = await userDbHelper.deleteUser(uid);
    print('deleted $rowsDeleted row(s): row $id');
  }

  void _insertStory(
      String uid, String title, String body, String userUid) async {
    Map<String, dynamic> row = {
      StoryDatabaseHelper.columnStoryUid: uid,
      StoryDatabaseHelper.columnTitle: title,
      StoryDatabaseHelper.columnBody: body,
      StoryDatabaseHelper.columnUseruid: userUid
    };

    final storyUid = await storyDbHelper.insertStoryData(row);
    print('added row id : $storyUid');
  }

  void _queryStory() async {
    final storyAllRows = await storyDbHelper.queryAllStory();
    print('query all rows: ');
    setState(() {
      storyDatas.clear();
    });
    storyAllRows.forEach((element) {
      setState(() {
        storyDatas.add(element);
      });
    });
  }

  void _updateStory(String storyUid, String title, String body) async {
    // row to update
    Map<String, dynamic> row = {
      StoryDatabaseHelper.columnStoryUid: storyUid,
      StoryDatabaseHelper.columnTitle: title,
      StoryDatabaseHelper.columnBody: body
    };
    final rowsAffected = await storyDbHelper.updateStory(row);
    print('updated $rowsAffected row(s)');
  }

  void _deleteStory(String storyUid) async {
    final total = await storyDbHelper.queryRowCount();
    final rowsDeleted = await storyDbHelper.deleteStory(storyUid);
    print('deleted $rowsDeleted row(s): row  $total');
  }
}
