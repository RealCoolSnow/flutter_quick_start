import 'package:flutter/foundation.dart';
import 'package:flutter_quick_start/common_libs.dart';
import 'package:flutter_quick_start/logic/common/save_load_mixin.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final currentLocale = ValueNotifier<String?>(null)
    ..addListener(scheduleSave);
  late final hasLogged = ValueNotifier<bool>(false)..addListener(scheduleSave);

  final bool useBlurs = defaultTargetPlatform != TargetPlatform.android;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    currentLocale.value = value['currentLocale'] ?? 'en';
    hasLogged.value = value['hasLogged'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'currentLocale': currentLocale.value,
      'hasLogged': hasLogged.value
    };
  }

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    // await localeLogic.loadIfChanged(value);
    // // Re-init controllers that have some cached data that is localized
    // wondersLogic.init();
    // timelineLogic.init();
  }
}
