
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

  String getMomentString() {
    var momentString = "";
    switch (entryMomentSpecifier) {
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

enum MomentSpecifier { BEFORE_MEAL, AFTER_MEAL }

enum MealTypeSpecifier { BREAKFAST, LUNCH, DINNER, SNACK }
