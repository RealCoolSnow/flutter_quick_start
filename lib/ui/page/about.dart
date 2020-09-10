/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:21:50
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:24:30
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easy/locale/i18n.dart';

class AboutPage extends StatefulWidget {
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(I18n.of(context).text("about")),
      ),
      body: Center(
        child: Text(I18n.of(context).text("about")),
      ),
    );
  }
}
