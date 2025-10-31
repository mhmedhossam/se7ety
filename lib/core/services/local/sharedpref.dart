import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  setData(dynamic data, String key) {
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

  getData(String key) {
    return pref.get(key);
  }
}
