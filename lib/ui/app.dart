/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:38:59
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:50:00
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easy/config/config.dart';
import 'package:flutter_easy/config/pref_key.dart';
import 'package:flutter_easy/config/route/routes.dart';
import 'package:flutter_easy/locale/i18n.dart';
import 'package:flutter_easy/locale/locale_util.dart';
import 'package:flutter_easy/storage/Pref.dart';
import 'package:flutter_easy/util/log_util.dart';
import 'package:flutter_easy/util/time_util.dart';

class App extends StatefulWidget {
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    //---router
    final router = Router();
    Routes.configureRoutes(router);
    Config.router = router;
    //---shared preferences
    Pref.setString(PrefKey.launchTime, TimeUtil.format(DateTime.now()));
    Pref.getString(PrefKey.launchTime)
        .then((value) => print('launch time: $value'));
    //---logutil
    logUtil.setEnabled(Config.debug);
    logUtil.d("log - d");
    logUtil.d2("log no stack - d");
  }
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Flutter Easy',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.pink,
      ),
      localizationsDelegates: [
        const I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: localeUtil.supportedLocales(),
      onGenerateRoute: Config.router.generator,
    );
    return app;
  }
}
