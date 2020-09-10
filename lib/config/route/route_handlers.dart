/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:44:05
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 11:58:58
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/ui/page/about.dart';
import 'package:flutter_easy/ui/page/home.dart';

/// home
var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomePage();
});

/// about
var aboutHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return AboutPage();
});
