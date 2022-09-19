import 'package:flutter_quick_start/constant/constant.dart';

/// Loads bitmap assets into memory that may be required later
class AppBitmaps {
  static Future<void> init() async {}
}

class ImagePaths {
  static const String root = 'assets/images/';
  static const String tab = 'assets/images/tab/';
}

class ImageFiles {
  static const String splash = ImagePaths.root + 'splash.jpg';
  static const String avatar = ImagePaths.root + 'avatar.jpg';
  static const String tab_home_normal =
      ImagePaths.tab + 'ic_tab_home_normal.png';
  static const String tab_home_active =
      ImagePaths.tab + 'ic_tab_home_active.png';
  static const String tab_circle_normal =
      ImagePaths.tab + 'ic_tab_circle_normal.png';
  static const String tab_circle_active =
      ImagePaths.tab + 'ic_tab_circle_active.png';
  static const String tab_me_normal = ImagePaths.tab + 'ic_tab_me_normal.png';
  static const String tab_me_active = ImagePaths.tab + 'ic_tab_me_active.png';
}
