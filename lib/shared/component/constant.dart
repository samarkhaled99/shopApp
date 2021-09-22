//  https://student.valuxapps.com/api/
// Content-Type  application/json


import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

import 'component.dart';

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
///
/// /static Future<bool> saveData(
//       {@required String key, @required dynamic value})
//   async{
// if(value is String) return await sharedPreferences.setString(key, value);
// if(value is int) return await sharedPreferences.setInt(key, value);
// if(value is bool) return await sharedPreferences.setBool(key, value);
// return await sharedPreferences.setDouble(key, value);
//
//   }


void signOut(context){

  CacheHelper.sharedPreferences.remove('token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String Text){
  final pattern= RegExp('.{1,800}');
  pattern.allMatches(Text).forEach((match) {print(match.group(0)); });
}

String token='';

