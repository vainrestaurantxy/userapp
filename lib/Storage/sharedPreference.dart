


import 'package:shared_preferences/shared_preferences.dart';

setLocal({required String key,required String value})async{
    SharedPreferences local = await SharedPreferences.getInstance();
    local.setString(key, value);
}

Future<String> getLocal({required String key})async{
    SharedPreferences local = await SharedPreferences.getInstance();
    return local.getString(key)??"";
}