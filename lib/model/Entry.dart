import 'dart:ffi';

import 'package:uuid/uuid.dart';

class Entry {
  String id;
  int bloodSugarLevel;
  int carbohydratesIntake;
  double insulinIntake;
  String entryTime;
  String entryHour;
  int physicalActivityDuration;
  MomentSpecifier entryMomentSpecifier;
  MealTypeSpecifier mealTypeSpecifier;

  Entry(this.id, this.bloodSugarLevel, this.carbohydratesIntake,
      this.insulinIntake, this.entryTime, this.entryHour,
      this.physicalActivityDuration, this.entryMomentSpecifier,
      this.mealTypeSpecifier);
}

enum MomentSpecifier { BEFORE_MEAL, AFTER_MEAL }

enum MealTypeSpecifier { BREAKFAST, LUNCH, DINNER, SNACK }
