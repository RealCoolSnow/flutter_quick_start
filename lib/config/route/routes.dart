/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:47:39
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:25:12
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/config/route/route_handlers.dart';

/// Usage:
///
/// router.navigateTo(context, Routes.home, transition: TransitionType.fadeIn);
///
///
class Routes {
  static const String home = "/";
  static const String about = "/about";
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(home, handler: homeHandler);
    router.define(about, handler: aboutHandler);
  }
}
