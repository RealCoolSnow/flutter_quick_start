/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 13:52:43
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 13:55:29
 */
import 'package:clipboard/clipboard.dart';

class ClipboardUtil {
  static Future<void> copy(String text) {
    return FlutterClipboard.copy(text);
  }

  static Future<String> paste() {
    return FlutterClipboard.paste();
  }
}
