/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 16:01:48
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 16:38:43
 */
import 'package:flutter/material.dart';
import 'package:flutter_easy/config/config.dart';
import 'package:flutter_easy/config/route/routes.dart';
import 'package:flutter_easy/service/http/http_util.dart';
import 'package:flutter_easy/util/log_util.dart';
import 'package:flutter_easy/util/permission_util.dart';
import 'package:flutter_easy/util/time_util.dart';
import 'package:flutter_easy/util/toast_util.dart';
import 'package:permission_handler/permission_handler.dart';

class Tab1 extends StatelessWidget {
  var _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
        child: Column(
      children: [
        RaisedButton(onPressed: _showNow, child: Text('Toast')),
        RaisedButton(onPressed: _showWebView, child: Text('WebView')),
        RaisedButton(
            onPressed: _permissionRequest, child: Text("Permission Request")),
        RaisedButton(onPressed: _httpTest, child: Text('Http Test'))
      ],
    ));
  }

  _showNow() {
    String now = TimeUtil.format(DateTime.now());
    logUtil.d(now);
    ToastUtil.show(now);
  }

  _showWebView() {
    final url = Uri.encodeComponent(
        'https://www.baidu.com'); //Uri.encodeComponent('assets/test.html');
    const title = '';
    Config.router
        .navigateTo(_context, Routes.webview + "?url=$url&title=$title");
  }

  _permissionRequest() async {
    Map<Permission, PermissionStatus> result = await PermissionUtil.requestAll(
        [Permission.location, Permission.storage]);
    ToastUtil.show(
        'Permission.location: ' + result[Permission.location].toString());
    ToastUtil.show(
        'Permission.storage: ' + result[Permission.storage].toString());
  }

  _httpTest() {
    HttpUtil()
        .get('/', getParams: {"user": "coolsnow"})
        .then((value) => ToastUtil.show(value.toString()))
        .catchError((error) => {ToastUtil.show(error.msg)});
  }
}
