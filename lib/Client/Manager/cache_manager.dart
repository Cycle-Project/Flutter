//
//  cache_manager.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 30.12.2022.
//

import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static Future saveSharedPref({required String tag, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tag, value);
  }

  static Future<String?> getSharedPref({required String tag}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tag);
  }

  static Future remove({required String tag}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tag);
  }
}