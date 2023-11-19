import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:grandshop/models/loginResponseModel.dart';

import '../ui/sign_in.dart';

class SharedServices {
  static Future<bool> isLoggedIn() async {
    var isKeyExist = APICacheManager().isAPICacheKeyExist("login_key");
    return isKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login_key");
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_key");
      return loginResponseModel(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(LoginResponseModel loginResponse) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "key", syncData: jsonEncode(loginResponse.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_key");
    Navigator.pushNamedAndRemoveUntil(context, SignIn.id, (route) => false);
  }
}
