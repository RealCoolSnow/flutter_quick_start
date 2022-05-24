/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 16:21:58
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 11:57:42
 */
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

///
/// Toast util
///
class ToastUtil {
  static void show(BuildContext context, String msg) {
    showToast(msg,
        context: context,
        animation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade);
  }
}
