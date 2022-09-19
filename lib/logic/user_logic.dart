import 'package:flutter_quick_start/common_libs.dart';

class UserLogic {
  void doLoginIfUnLogin() {
    logUtil.d('doLoginIfUnLogin-' +
        (settingsLogic.hasLogged.value ? 'true' : 'false'));
    settingsLogic.hasLogged.value = !settingsLogic.hasLogged.value;
  }
}
