/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-10 18:00:00
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 18:48:27
 */
import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// webview page
///
/// @TODO:
///
/// Javascript Channel、Progress bar、right menu
///
class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  WebViewPage({@required this.url, this.title = ""});
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String _url;
  String _title = "";
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    _url = Uri.decodeComponent(widget.url);
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // TODO(iskakaushik): Remove this when collection literals makes it to stable.
          // ignore: prefer_collection_literals
          javascriptChannels: <JavascriptChannel>[
            //_toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   print('blocking navigation to $request}');
            //   return NavigationDecision.prevent;
            // }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ));
  }
}
