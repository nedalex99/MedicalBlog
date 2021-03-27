import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferencesUtils extends FlutterSecureStorage {
  static Future<PreferencesUtils> get _instance async =>
      _prefsInstance ??= PreferencesUtils();
  static PreferencesUtils _prefsInstance;

  static Future<PreferencesUtils> init() async {
    if (_prefsInstance == null) {
      _prefsInstance = await _instance;
    }
    return _prefsInstance;
  }

  Future<String> getTutorialFlag(String key, String defValue) async {
    return _prefsInstance.read(key: key) ?? defValue ?? false;
  }

  Future<void> setTutorialFlag(String key, bool value) async {
    return _prefsInstance.write(key: key, value: value.toString());
  }
}
