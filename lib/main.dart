/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 17:59:49
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:23:24
 */
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_quick_start/app_sentry.dart';
import 'package:flutter_quick_start/logic/app_logic.dart';
import 'package:flutter_quick_start/logic/settings_logic.dart';
import 'package:flutter_quick_start/logic/user_logic.dart';
import 'package:flutter_quick_start/service/api/demo_api.dart';
import 'package:flutter_quick_start/ui/app.dart';
import 'package:flutter_quick_start/common_libs.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  registerSingletons();
  await appLogic.bootstrap();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => AppSentry.runWithCatchError(App()));
}

void registerSingletons() {
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  GetIt.I.registerLazySingleton<UserLogic>(() => UserLogic());
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  GetIt.I.registerLazySingleton<DemoApi>(() => DemoApi());
}

AppLogic get appLogic => GetIt.I.get<AppLogic>();
UserLogic get userLogic => GetIt.I.get<UserLogic>();
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
DemoApi get demoApi => GetIt.I.get<DemoApi>();