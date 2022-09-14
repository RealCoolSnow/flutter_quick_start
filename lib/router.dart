import 'package:flutter_quick_start/ui/page/about.dart';
import 'package:flutter_quick_start/ui/page/home.dart';
import 'package:flutter_quick_start/ui/page/hooks_demo.dart';
import 'package:flutter_quick_start/ui/webview/webview.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const homePage = 'app://';
  static const aboutPage = 'app://AboutPage';
  static const hookPage = 'app://HookPage';

  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('http')) {
      return WebViewPage(
          url: url, title: params['title'] == null ? "" : params['title']);
    } else {
      switch (url) {
        case homePage:
          return HomePage();
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

  AppRouter.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  AppRouter.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
