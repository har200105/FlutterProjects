import 'package:shared_preferences/shared_preferences.dart';

class Cache {
   readCache({required String key}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var cache = await sharedPreferences.getString(key);
    return cache;
  }
}