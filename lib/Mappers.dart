import 'MusclePart.dart';

class Mappers {
  static String convertEnumToString(MusclePart cat) {
    switch (cat) {
      case MusclePart.LEGS:
        return "legs";
      case MusclePart.CORE:
        return "core";
      case MusclePart.ARMS:
        return "arms";
      case MusclePart.BACK:
        return "back";
      case MusclePart.CHEST:
        return "chest";
      case MusclePart.SHOULDERS:
        return "shoulders";
      case MusclePart.CARDIO:
        return "cardio";
      case MusclePart.ANY:
        return "all muscles";
      default:
        return "";
    }
  }

  static MusclePart convertStringToEnum(String cat) {
    switch (cat) {
      case "calves":
      case "legs":
      case "thighs":
        return MusclePart.LEGS;
      case "waist":
      case "core":
      case "hips":
        return MusclePart.CORE;
      case "arms":
      case "forearms":
      case "upper arms":
        return MusclePart.ARMS;
      case "back":
        return MusclePart.BACK;
      case "chest":
        return MusclePart.CHEST;
      case "shoulders":
        return MusclePart.SHOULDERS;
      case "cardio":
        return MusclePart.CARDIO;
      case "all muscles":
        return MusclePart.ANY;
      default:
        return MusclePart.ANY;
    }
  }

  static Equipment convertStringToEquipment(String value) {
    switch (value) {
      case "body weight":
        return Equipment.bodyweight;
      case "cable":
        return Equipment.cable;
      case "leverage machine":
      case "assisted":
        return Equipment.assisted;
      case "medicine ball":
      case "stability ball":
      case "rollball":
      case "bosu ball":
      case "stability ball":
        return Equipment.ball;
      case "barbell":
      case "ez barbell":
      case "olympic barbell":
        return Equipment.barbell;
      case "dumbbell":
        return Equipment.dumbbell;
      default:
        return Equipment.any;
    }
  }

  static String equipmentEnumToString(Equipment equipment) {
    switch (equipment) {
      case Equipment.bodyweight:
        return "body weight";
      case Equipment.cable:
        return "cable";
      case Equipment.assisted:
        return "assisted";
      case Equipment.ball:
        return "ball";
      case Equipment.barbell:
        return "barbell";
      case Equipment.dumbbell:
        return "dumbbell";
      default:
        return "all equipment";
    }
  }
}


//Complete
/*
class Mappers {
  static String convertEnumToString(MusclePart cat) {
    switch (cat) {
      case MusclePart.LEGS:
        return "legs";
      case MusclePart.CORE:
        return "core";
      case MusclePart.ARMS:
        return "arms";
      case MusclePart.BACK:
        return "back";
      case MusclePart.CHEST:
        return "chest";
      case MusclePart.SHOULDERS:
        return "shoulders";
      case MusclePart.CARDIO:
        return "cardio";
      case MusclePart.PLYOMETRICS:
        return "plyometrics";
      case MusclePart.YOGA:
        return "yoga";
      case MusclePart.CROSSFIT:
        return "crossFit";
      case MusclePart.STRETCHING:
        return "stretching";
      case MusclePart.ANY:
        return "all muscles";
      default:
        return "";
    }
  }

  static MusclePart convertStringToEnum(String cat) {
    switch (cat) {
      case "calves":
      case "legs":
        return MusclePart.LEGS;
      case "waist":
      case "core":
      case "hips":
        return MusclePart.CORE;
      case "arms":
      case "forearms":
        return MusclePart.ARMS;
      case "back":
        return MusclePart.BACK;
      case "chest":
        return MusclePart.CHEST;
      case "shoulders":
        return MusclePart.SHOULDERS;
      case "cardio":
        return MusclePart.CARDIO;
      case "plyometrics":
        return MusclePart.PLYOMETRICS;
      case "yoga":
        return MusclePart.YOGA;
      case "crossFit":
        return MusclePart.CROSSFIT;
      case "stretching":
        return MusclePart.STRETCHING;
      case "all muscles":
        return MusclePart.ANY;
      default:
        return MusclePart.ANY;
    }
  }

  static Equipment convertStringToEquipment(String value) {
    switch (value) {
      case "body weight":
        return Equipment.bodyweight;
      case "band":
        return Equipment.band;
      case "cable":
        return Equipment.cable;
      case "leverage machine":
      case "assisted":
        return Equipment.assisted;
      case "medicine ball":
      case "stability ball":
      case "rollball":
      case "bosu ball":
      case "stability ball":
        return Equipment.ball;
      case "barbell":
      case "ez barbell":
      case "olympic barbell":
        return Equipment.barbell;
      case "rope":
      case "battling rope":
        return Equipment.rope;
      case "dumbbell":
        return Equipment.dumbbell;
      case "kettlebell":
        return Equipment.kettlebell;
      case "suspension":
        return Equipment.suspension;
      default:
        return Equipment.any;
    }
  }

  static String equipmentEnumToString(Equipment equipment) {
    switch (equipment) {
      case Equipment.bodyweight:
        return "body weight";
      case Equipment.band:
        return "band";
      case Equipment.cable:
        return "cable";
      case Equipment.assisted:
        return "assisted";
      case Equipment.ball:
        return "ball";
      case Equipment.barbell:
        return "barbell";
      case Equipment.rope:
        return "rope";
      case Equipment.dumbbell:
        return "dumbbell";
      case Equipment.kettlebell:
        return "kettlebell";
      case Equipment.suspension:
        return "suspension";
      default:
        return "all equipment";
    }
  }
}
 */