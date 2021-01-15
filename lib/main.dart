/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 17:59:49
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:23:24
 */
import 'package:flutter_quick_start/app_sentry.dart';
import 'package:flutter_quick_start/ui/app.dart';

void main() => AppSentry.runWithCatchError(App());
