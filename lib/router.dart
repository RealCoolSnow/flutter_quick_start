import 'package:flutter_quick_start/ui/page/about.dart';
import 'package:flutter_quick_start/ui/page/hooks_demo.dart';
import 'package:flutter_quick_start/ui/webview/webview.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const aboutPage = 'app://AboutPage';
  static const hookPage = 'app://HookPage';

  Widget _getPage(String path, Map<String, dynamic> params) {
    if (path.startsWith('http')) {
      return WebViewPage(
          url: path, title: params['title'] == null ? "" : params['title']);
    } else {
      switch (path) {
        case aboutPage:
          return AboutPage();
        case hookPage:
          return HooksDemoPage();
      }
    }
    return Container(
      child: Center(child: Text('404')),
    );
  }

  AppRouter.push(BuildContext context, String path,
      {Map<String, dynamic> params = const {}}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(path, params);
    }));
  }
  AppRouter.redirect(BuildContext context, String path,
      {Map<String, dynamic> params = const {}}) {
    Navigator.pop(context);
    AppRouter.push(context, path, params: params);
  }
}
