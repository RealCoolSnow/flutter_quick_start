import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum AppLocaleSupported { enUS, zhCN }

const enUS_l = Locale('en', 'US');
const zhCN_1 = Locale('zh', 'CN');

class AppLocale {
  static const path = 'assets/locale';
  static const supportedLocales = [enUS_l, zhCN_1];
  static AppLocaleSupported currentLocale = AppLocaleSupported.enUS;
  static Widget wrapApp(Widget appMain) {
    return EasyLocalization(
        supportedLocales: supportedLocales,
        path: path,
        fallbackLocale: supportedLocales[0],
        child: appMain);
  }

  static void switchLocale(BuildContext context, AppLocaleSupported locale) {
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
  /// AppLocale.t('name')
  /// AppLocale.t('name', args: ['Dart'])
  /// AppLocale.t('name', namedArgs: {'lang': 'Dart'})
  static String t(
    String name, {
    List<String>? args,
    Map<String, String>? namedArgs,
  }) =>
      name.tr(args: args, namedArgs: namedArgs);
}
