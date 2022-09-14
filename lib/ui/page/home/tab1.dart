/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 16:01:48
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-17 19:05:39
 */
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/config/config.dart';
import 'package:flutter_quick_start/config/pref_key.dart';
import 'package:flutter_quick_start/models/counter.dart';
import 'package:flutter_quick_start/router.dart';
import 'package:flutter_quick_start/service/http/http_util.dart';
import 'package:flutter_quick_start/storage/Pref.dart';
import 'package:flutter_quick_start/util/device_util.dart';
import 'package:flutter_quick_start/util/loading_util.dart';
import 'package:flutter_quick_start/util/log_util.dart';
import 'package:flutter_quick_start/util/permission_util.dart';
import 'package:flutter_quick_start/util/time_util.dart';
import 'package:flutter_quick_start/util/toast_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Tab1 extends StatefulWidget {
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  var _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return FlutterEasyLoading(
        child: Container(
            child: Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                var counter = context.read<Counter>();
                counter.increment();
              },
              child: Consumer<Counter>(
                builder: (context, counter, child) =>
                    Text('Counter: ${counter.value}'),
              ),
            )),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: () {
                  AppRouter.push(context, AppRouter.hookPage, null);
                },
                child: Text('Hooks'))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(onPressed: _showToast, child: Text('Toast'))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: _showLoading, child: Text('Loading'))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: _showPreferences,
                child: Text('Shared Preferences'))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: _showDeviceInfo, child: Text('Device Info'))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: _showWebView, child: Text('WebView'))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: _permissionRequest,
                child: Text("Permission Request"))),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child:
                ElevatedButton(onPressed: _httpTest, child: Text('Http Test'))),
        _buildHero()
      ],
    )));
  }

  _buildHero() {
    return Container(
        child: GestureDetector(
            child: Hero(
                tag: "myhero",
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    radius: 30)),
            onTap: () {
              AppRouter.push(context, AppRouter.aboutPage, null);
            }));
  }

  _showToast() {
    String now = TimeUtil.format(DateTime.now());
    logUtil.d(now);
    ToastUtil.show(context, now);
  }

  _showLoading() {
    LoadingUtil.show(context);
    Future.delayed(Duration(seconds: 2), () {
      LoadingUtil.dismiss();
    });
  }

  _showPreferences() {
    Pref.getString(PrefKey.launchTime, "").then((value) {
      String str = 'launch time: $value';
      ToastUtil.show(context, str);
    });
  }

  _showDeviceInfo() {
    DeviceUtil.getDeviceInfo().then((value) => ToastUtil.show(context, value));
  }

  _showWebView() {
    final url = Uri.encodeComponent(
        'https://github.com/RealCoolSnow/flutter_easy'); //Uri.encodeComponent('assets/test.html');
    const title = 'RealCoolSnow';
    AppRouter.push(context, url, {'title': title});
  }

  _permissionRequest() async {
    if (DeviceUtil.isMobile()) {
      Map<Permission, PermissionStatus> result =
          await PermissionUtil.requestAll(
              [Permission.location, Permission.storage]);
      ToastUtil.show(context,
          'Permission.location: ' + result[Permission.location].toString());
      ToastUtil.show(context,
          'Permission.storage: ' + result[Permission.storage].toString());
    } else {
      ToastUtil.show(context, 'Not support Desktop platform');
    }
  }

  _httpTest() {
    LoadingUtil.show(context);
    HttpUtil().get('/', getParams: {"user": "coolsnow"}).then((value) {
      LoadingUtil.dismiss();
      ToastUtil.show(context, value.toString());
    }).catchError((error) {
      LoadingUtil.dismiss();
      ToastUtil.show(context, error.msg);
    });
  }
}
