import 'package:diastore_flutter/views/EntriesList.dart';
import 'package:flutter/material.dart';

import 'model/Entry.dart';

void main() => runApp(MyApp(null));

class MyApp extends StatelessWidget {
  final Entry entry;
  MyApp(this.entry);

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
