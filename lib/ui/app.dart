import 'dart:io';
import 'package:flutter_quick_start/models/counter.dart';
import 'package:flutter_quick_start/ui/page/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_quick_start/constant/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_quick_start/common_libs.dart';

class App extends StatelessWidget {
  App() {
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
              theme: $styles.colors.toThemeData(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: SplashScreen(seconds: 0),
            );
          }),
    );
  }
}
