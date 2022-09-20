import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum AppLocaleSupported { enUS, zhCN }

const zhCN_1 = Locale('zh', 'CN');
const enUS_l = Locale('en', 'US');

final $locale = AppLocale();

class AppLocale {
  static const path = 'assets/locale';
  static const supportedLocales = [zhCN_1, enUS_l];
  AppLocaleSupported currentLocale = AppLocaleSupported.zhCN;
  Widget wrapApp(Widget appMain) {
    return EasyLocalization(
        supportedLocales: supportedLocales,
        path: path,
        fallbackLocale: supportedLocales[0],
        startLocale: supportedLocales[0],
        child: appMain);
  }

  void switchLocale(BuildContext context, AppLocaleSupported locale) {
    // logUtil.d('switchLocale: ' + locale.toString());
    switch (locale) {
      case AppLocaleSupported.enUS:
        context.setLocale(enUS_l);
        break;
      case AppLocaleSupported.zhCN:
        context.setLocale(zhCN_1);
        break;
    }
    currentLocale = locale;
  }

  ///
  /// $locale.t('name')
  /// $locale.t('name', args: ['Dart'])
  /// $locale.t('name', namedArgs: {'lang': 'Dart'})
  String t(
    String name, {
    List<String>? args,
    Map<String, String>? namedArgs,
  }) =>
      name.tr(args: args, namedArgs: namedArgs);
}
