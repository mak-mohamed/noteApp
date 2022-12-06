import 'package:get_storage/get_storage.dart';

class MyGetstorange {
// Write DATA
  static void saveData(String key, dynamic value) async {
    await GetStorage().write(key, value);
  }

// Read Data
  static String? readData(String key) {
    return GetStorage().read(key);
  }
}
