import 'dart:ui';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quick_start/constant/constant.dart';
import 'package:flutter_quick_start/constant/pref_key.dart';
import 'package:flutter_quick_start/models/counter.dart';
import 'package:flutter_quick_start/ui/app_theme.dart';
import 'package:flutter_quick_start/ui/page/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quick_start/storage/Pref.dart';
import 'package:flutter_quick_start/util/log_util.dart';
import 'package:flutter_quick_start/util/time_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    logUtil.setEnabled(Constant.debug);
    logUtil.d("App created");
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (cxt, child) {
            return MaterialApp(
              title: Constant.app,
              debugShowCheckedModeBanner: false,
              theme: new ThemeData(
                primarySwatch: AppTheme.primary,
                splashColor: AppTheme.splash,
              ),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: Scaffold(body: SplashScreen(seconds: 0)),
            );
          }),
    );
  }
}
