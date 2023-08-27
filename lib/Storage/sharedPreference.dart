import 'dart:html';
import 'package:shared_preferences/shared_preferences.dart';

setLocal({required String key, required String value}) async {
  // SharedPreferences local = await SharedPreferences.getInstance();
  // local.setString(key, value);
  final Storage _localStorage = window.localStorage;
  _localStorage[key] = value;
}

Future<String> getLocal({required String key}) async {
  // SharedPreferences local = await SharedPreferences.getInstance();
  // return local.getString(key)??"";
  final Storage _localStorage = window.localStorage;
  return _localStorage[key] ?? "";
}

remove({required String key}) {
  final Storage _localStorage = window.localStorage;
  _localStorage.remove(key);
}
