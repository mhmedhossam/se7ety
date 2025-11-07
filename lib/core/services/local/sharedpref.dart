import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;
  static const kToken = 'token';
  static const kPatientUid = 'kPatientUid';
  static const kDoctorId = 'kDoctorId';
  static const kUserData = 'kUserData';
  static const kOnBoardingShown = 'kOnBoardingShown';

  static initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  static void setOnBoardingShown() {
    pref.setBool(kOnBoardingShown, true);
  }

  static bool get getOnBoardingShown {
    return pref.getBool(kOnBoardingShown) ?? false;
  }

  static setData(String key, dynamic data) {
    if (data is String) {
      pref.setString(key, data);
    } else if (data is double) {
      pref.setDouble(key, data);
    } else if (data is int) {
      pref.setInt(key, data);
    } else if (data is List<String>) {
      pref.setStringList(key, data);
    } else {
      pref.setBool(key, data);
    }
  }

  static getData(String key) {
    return pref.get(key);
  }
}
