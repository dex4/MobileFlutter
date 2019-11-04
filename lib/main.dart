import 'package:diastore_flutter/feature/entrieslist/EntriesList.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DiaStore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("DiaStore"),
          ),
          body: Center(
            child: Entries(),
          ),
        ));
  }
}
