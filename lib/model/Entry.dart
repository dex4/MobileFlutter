class Entry {
  String id;
  int bloodSugarLevel;
  int carbohydratesIntake;
  double insulinIntake;
  String entryTime;
  String entryHour;
  int physicalActivityDuration;
  String entryMomentSpecifier;
  String mealTypeSpecifier;

  Entry(
      this.id,
      this.bloodSugarLevel,
      this.carbohydratesIntake,
      this.insulinIntake,
      this.entryTime,
      this.entryHour,
      this.physicalActivityDuration,
      this.entryMomentSpecifier,
      this.mealTypeSpecifier);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bloodSugarLevel': bloodSugarLevel,
      'carbohydratesIntake': carbohydratesIntake,
      'insulinIntake': insulinIntake,
      'entryTime': entryTime,
      'entryHour': entryHour,
      'physicalActivityDuration': physicalActivityDuration,
      'entryMomentSpecifier': entryMomentSpecifier,
      'mealTypeSpecifier': mealTypeSpecifier,
    };
  }

  String getMomentString() {
    var momentString = "";
    switch (entryMomentSpecifier.toString()) {
      case MomentSpecifier.BEFORE_MEAL:
        momentString += "Before ";
        break;
      case MomentSpecifier.AFTER_MEAL:
        momentString += "After ";
        break;
    }

    switch (mealTypeSpecifier) {
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

class MomentSpecifier {
  static const BEFORE_MEAL = "BEFORE_MEAL";
  static const AFTER_MEAL = "AFTER_MEAL";
}

class MealTypeSpecifier {
  static const BREAKFAST = "BREAKFAST";
  static const LUNCH = "LUNCH";
  static const DINNER = "DINNER";
  static const SNACK = "SNACK";
}
