/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 17:59:49
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:23:24
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quick_start/app_sentry.dart';
import 'package:flutter_quick_start/ui/app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => AppSentry.runWithCatchError(App()));
}
