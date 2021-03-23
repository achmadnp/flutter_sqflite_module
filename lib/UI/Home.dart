import 'package:flutter/material.dart';
import 'package:flutter_sqflite_module/repos/DatabaseHelper.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQFlite module demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _insert();
                },
                child: Text('insert data')),
            ElevatedButton(
                onPressed: () {
                  _query();
                },
                child: Text('query data')),
            ElevatedButton(
                onPressed: () {
                  _update();
                },
                child: Text('update data')),
            ElevatedButton(
                onPressed: () {
                  _delete();
                },
                child: Text('delete data')),
          ],
        ),
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'John',
      DatabaseHelper.columnAge: 22
    };
    final id = await dbHelper.insert(row);
    print('added row id : $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows: ');
    allRows.forEach((element) => print(element));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: 'Mary',
      DatabaseHelper.columnAge: 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
