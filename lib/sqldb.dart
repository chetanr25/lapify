import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class GetInfoFromDB extends StatelessWidget {
  const GetInfoFromDB({super.key});
  void getInfo() async {
    final Database database = await openDatabase('LapifyData.db');
    final List<Map<String, dynamic>> info = await database.query('specs');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Result Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Get Info From DB'),
              ElevatedButton(
                onPressed: getInfo,
                child: const Text('Get Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
