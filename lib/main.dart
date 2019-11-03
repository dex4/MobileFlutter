import 'package:diastore_flutter/model/Entry.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  List<Entry> entries = [
    Entry(Uuid().v1(), 124, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.BREAKFAST)
  ];

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
            child: EntryCard(entries[0]),
          ),
        ));
  }
}

class EntryCard extends StatelessWidget {
  Entry entry;

  EntryCard(this.entry);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entry.bloodSugarLevel.toString()),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Column(children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child:
                                  Text("Carbs: ${entry.carbohydratesIntake}")),
                          Expanded(
                              child: Text("Insulin: ${entry.insulinIntake}")),
                          Expanded(
                              child: Text(
                                  "Sport: ${entry.physicalActivityDuration}")),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[Text(entry.entryHour)],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[Text("${entry.entryTime} ${getMomentString(entry.entryMomentSpecifier, entry.mealTypeSpecifier)}")],
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                width: 24,
                margin: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getMomentString(MomentSpecifier momentSpecifier, MealTypeSpecifier mealTypeSpecifier) {
    var momentString = "";
    switch(momentSpecifier) {

      case MomentSpecifier.BEFORE_MEAL:
        momentString += "Before ";
        break;
      case MomentSpecifier.AFTER_MEAL:
        momentString += "After ";
        break;
    }

    switch(mealTypeSpecifier) {

      case MealTypeSpecifier.BREAKFAST:
        momentString += "Breakfast";
        break;
      case MealTypeSpecifier.LUNCH:
        momentString += "Lunch";
        break;
      case MealTypeSpecifier.DINNER:
        momentString += "Dinner";
        break;
      case MealTypeSpecifier.SNACK:
        momentString += "Snack";
        break;
    }
    return momentString;
  }
}