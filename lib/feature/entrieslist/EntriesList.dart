import 'dart:ffi';

import 'package:diastore_flutter/feature/details/EntryDetailsScreen.dart';
import 'package:diastore_flutter/model/Entry.dart';
import 'package:diastore_flutter/views/EntryCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class Entries extends StatefulWidget {
  @override
  EntriesState createState() => new EntriesState();
}

class EntriesState extends State<Entries> {

  Future<Database> database;
  final List<Entry> entries = [];
  bool gotInitialData = false;

  Future<void> openDB() async {
    database = openDatabase(
      p.join(await getDatabasesPath(), 'entries-database.db'),
      onCreate: (db, version) {
        return db.execute(
          "create table Entries(id text primary key, bloodSugarLevel integer, carbohydratesIntake integer,"
          "insulinIntake double, entryTime text, entryHour text, physicalActivityDuration integer,"
          "entryMomentSpecifier text, mealTypeSpecifier text)",
        );
      },
      version: 1,
    );
  }

  Future<List<Entry>> getEntries() async {
    final Database db = await database;
    final List<Map<String, dynamic>> entryMaps = await db.query('Entries');

    return List.generate(entryMaps.length, (i) {
      return Entry(
        entryMaps[i]['id'],
        entryMaps[i]['bloodSugarLevel'],
        entryMaps[i]['carbohydratesIntake'],
        entryMaps[i]['insulinIntake'],
        entryMaps[i]['entryTime'],
        entryMaps[i]['entryHour'],
        entryMaps[i]['physicalActivityDuration'],
        entryMaps[i]['entryMomentSpecifier'],
        entryMaps[i]['mealTypeSpecifier'],
      );
    });
  }

  Future<void> insertEntry(Entry entry) async {
    final Database db = await database;
    await db.insert(
      'Entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEntry(Entry entry) async {
    final db = await database;

    // Update the given Entry.
    await db.update(
      'Entries',
      entry.toMap(),
      where: "id = ?",
      whereArgs: [entry.id],
    );
  }

  Future<void> deleteEntry(Entry entry) async {
    final db = await database;

    // Delete the given Entry.
    await db.delete(
      'Entries',
      where: "id = ?",
      whereArgs: [entry.id],
    );
  }

  Future<List<Entry>> atBuild() async {
    await openDB();
    return await getEntries();
  }

//  final List<Entry> entries = [
//    Entry(Uuid().v1(), 124, 2, 3.0, "7:00", "10/10/10", 40,
//        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.BREAKFAST),
//    Entry(Uuid().v1(), 80, 2, 3.0, "7:00", "10/10/10", 40,
//        MomentSpecifier.AFTER_MEAL, MealTypeSpecifier.BREAKFAST),
//    Entry(Uuid().v1(), 105, 2, 3.0, "7:00", "10/10/10", 40,
//        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.LUNCH),
//    Entry(Uuid().v1(), 106, 2, 3.0, "7:00", "10/10/10", 40,
//        MomentSpecifier.AFTER_MEAL, MealTypeSpecifier.LUNCH),
//    Entry(Uuid().v1(), 107, 2, 3.0, "7:00", "10/10/10", 40,
//        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.DINNER),
//    Entry(Uuid().v1(), 108, 2, 3.0, "7:00", "10/10/10", 40,
//        MomentSpecifier.AFTER_MEAL, MealTypeSpecifier.DINNER),
//  ];

  @override
  Widget build(BuildContext context) {
    openDB();
    return FutureBuilder(
      future: atBuild(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data.toString());
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: onFloatingActionButtonPressed,
                child: Icon(Icons.add)),
            body: buildEntriesList(snapshot.data),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildEntriesList(List<Entry> entries) {
    if (entries != null && gotInitialData == false) {
      entries.forEach((entry) {
        this.entries.add(entry);
      });
      gotInitialData = true;
    }
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: this.entries.length,
        itemBuilder: (BuildContext _context, int i) {
          return EntryCard(
              this.entries[i],
              () => setState(() {
                    deleteEntry(this.entries[i]);
                    this.entries.removeAt(i);
                  }),
              (Entry entry) => setState(() {
                    onReceivedEntry(entry);
                  }));
        });
  }

  void onReceivedEntry(Entry entry) {
    bool isUpdatedEntry = false;
    int index = -1;
    for (int i = 0; i < entries.length; i++) {
      if (entries[i].id == entry.id) {
        isUpdatedEntry = true;
        index = i;
        break;
      }
    }
    if (isUpdatedEntry) {
      entries[index] = entry;
      updateEntry(entry);
    } else {
      insertEntry(entry);
      entries.add(entry);
    }
  }

  void onFloatingActionButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntryDetailsState(
            null,
            (Entry entry) => setState(() {
                  onReceivedEntry(entry);
                })),
      ),
    );
  }
}
