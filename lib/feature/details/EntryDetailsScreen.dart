import 'package:diastore_flutter/model/Entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EntryDetailsState extends StatefulWidget {
  final Entry entry;
  final Function callback;

  EntryDetailsState(this.entry, this.callback);

  @override
  EntryDetailsScreen createState() => new EntryDetailsScreen(entry, callback);
}

class EntryDetailsScreen extends State<EntryDetailsState> {
  Entry entry;
  String entryId;
  Function callback;
  int _entryTimeRadioValue = -1;
  int _mealTypeRadioValue = -1;
  final _bloodSugarController = TextEditingController();
  final _carbsController = TextEditingController();
  final _insulinController = TextEditingController();
  final _physicalActivityController = TextEditingController();

  EntryDetailsScreen(this.entry, this.callback);

  @override
  void initState() {
    super.initState();

    if (entry != null) {
      entryId = entry.id;
      _bloodSugarController.text = entry.bloodSugarLevel.toString();
      _carbsController.text = entry.carbohydratesIntake.toString();
      _insulinController.text = entry.insulinIntake.toString();
      _physicalActivityController.text =
          entry.physicalActivityDuration.toString();

      switch (entry.entryMomentSpecifier) {
        case MomentSpecifier.BEFORE_MEAL:
          _entryTimeRadioValue = 0;
          break;
        case MomentSpecifier.AFTER_MEAL:
          _entryTimeRadioValue = 1;
          break;
      }

      switch (entry.mealTypeSpecifier) {
        case MealTypeSpecifier.BREAKFAST:
          _mealTypeRadioValue = 0;
          break;
        case MealTypeSpecifier.LUNCH:
          _mealTypeRadioValue = 1;
          break;
        case MealTypeSpecifier.DINNER:
          _mealTypeRadioValue = 2;
          break;
        case MealTypeSpecifier.SNACK:
          _mealTypeRadioValue = 3;
          break;
      }
    }else {
      entryId = Uuid().v1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entry Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Bloodsugar:"),
                    Flexible(
                      child: TextFormField(
                        controller: _bloodSugarController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Carbs:"),
                    Flexible(
                      child: TextFormField(
                        controller: _carbsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Insulin Intake:"),
                    Flexible(
                      child: TextFormField(
                        controller: _insulinController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Physical activity duration:"),
                    Flexible(
                      child: TextFormField(
                        controller: _physicalActivityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Entry Moment"),
                    ),
                    Expanded(
                      child: Text("Meal Type"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _entryTimeRadioValue,
                              onChanged: setEntryTimeValue,
                            ),
                            Text("Before Meal"),
                          ]),
                          Row(children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _entryTimeRadioValue,
                              onChanged: setEntryTimeValue,
                            ),
                            Text("After Meal"),
                          ]),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _mealTypeRadioValue,
                              onChanged: setMealTypeValue,
                            ),
                            Text("Breakfast"),
                          ]),
                          Row(children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _mealTypeRadioValue,
                              onChanged: setMealTypeValue,
                            ),
                            Text("Lunch"),
                          ]),
                          Row(children: <Widget>[
                            Radio(
                              value: 2,
                              groupValue: _mealTypeRadioValue,
                              onChanged: setMealTypeValue,
                            ),
                            Text("Dinner"),
                          ]),
                          Row(children: <Widget>[
                            Radio(
                              value: 3,
                              groupValue: _mealTypeRadioValue,
                              onChanged: setMealTypeValue,
                            ),
                            Text("Snack"),
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: onSaveButtonPressed,
                      child: Text("Save"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setEntryTimeValue(int value) {
    setState(() {
      _entryTimeRadioValue = value;
    });
  }

  void setMealTypeValue(int value) {
    setState(() {
      _mealTypeRadioValue = value;
    });
  }

  MomentSpecifier getEntryTime() {
    MomentSpecifier et;
    switch (_entryTimeRadioValue) {
      case 0:
        et = MomentSpecifier.BEFORE_MEAL;
        break;
      case 1:
        et = MomentSpecifier.AFTER_MEAL;
        break;
    }
    return et;
  }

  MealTypeSpecifier getMealType() {
    MealTypeSpecifier mt;
    switch (_mealTypeRadioValue) {
      case 0:
        mt = MealTypeSpecifier.BREAKFAST;
        break;
      case 1:
        mt = MealTypeSpecifier.LUNCH;
        break;
      case 2:
        mt = MealTypeSpecifier.DINNER;
        break;
      case 3:
        mt = MealTypeSpecifier.SNACK;
        break;
    }
    return mt;
  }

  void onSaveButtonPressed() {
    var bs = _bloodSugarController.text;
    var carbs = _carbsController.text;
    var insulin = _insulinController.text;
    var sport = _physicalActivityController.text;
    Entry entry = Entry(
        entryId,
        int.parse(bs),
        int.parse(carbs),
        double.parse(insulin),
        "7:00",
        "10/10/10",
        int.parse(sport),
        getEntryTime(),
        getMealType());
    print(
        "Bs: $bs\nCarbs: $carbs\nInsulin: $insulin\nSport: $sport\nEntry time: ${getEntryTime()}\nMeal type: ${getMealType()}\n");
    print(entry.bloodSugarLevel);
    this.callback(entry);
    Navigator.pop(context);
  }
}
