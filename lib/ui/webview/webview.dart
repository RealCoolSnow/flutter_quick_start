/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-10 18:00:00
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 14:45:06
 */
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy/locale/i18n.dart';
import 'package:flutter_easy/ui/webview/channel/flutter_channel.dart';
import 'package:flutter_easy/util/clipboard_util.dart';
import 'package:flutter_easy/util/log_util.dart';
import 'package:flutter_easy/util/toast_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// webview page
///
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

  /// load html from local Assets
  bool _local = false;
  bool isLoading = true;
  bool canGoback = false;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  FlutterChannel flutterChannel = FlutterChannel();

  @override
  void initState() {
    super.initState();
    _url = Uri.decodeComponent(widget.url);
    _title = widget.title;
    _local = _url.startsWith("asset");
  }

  _loadHtmlFromAssets() async {
    WebViewController controller = await _controller.future;
    String fileHtmlContents = await rootBundle.loadString(_url);
    controller.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  _onPageStarted() {
    setState(() {
      isLoading = true;
    });
  }

  _onPageFinished() async {
    setState(() {
      isLoading = false;
    });
    WebViewController controller = await _controller.future;
    controller.canGoBack().then((value) => {
          setState(() {
            canGoback = value;
          })
        });
    if (_title.isEmpty) {
      controller.getTitle().then((value) => {
            setState(() {
              _title = value;
            })
          });
    }
  }

  _progressIndicator() {
    return Center(
        child: isLoading
            ? Container(
                color: Colors.transparent,
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white70, strokeWidth: 2.4))
            : IconButton(
                iconSize: canGoback ? 24.0 : 0,
                icon: new Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ));
  }

  _onBack() async {
    if (canGoback) {
      WebViewController controller = await _controller.future;
      controller.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: _onBack,
          ),
          title: Text(_title),
          actions: [_progressIndicator(), WebViewMenu(_controller.future)],
        ),
        body: WebView(
          initialUrl: _local ? "" : _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            if (_local) {
              _loadHtmlFromAssets();
            }
          },
          javascriptChannels: <JavascriptChannel>[
            flutterChannel.channel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   print('blocking navigation to $request}');
            //   return NavigationDecision.prevent;
            // }
            logUtil.i2('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            logUtil.i2('Page started loading: $url');
            _onPageStarted();
          },
          onPageFinished: (String url) {
            logUtil.i2('Page finished loading: $url');
            _onPageFinished();
          },
          gestureNavigationEnabled: true,
        ));
  }
}

enum MenuOptions { refresh, copyLink }

class WebViewMenu extends StatelessWidget {
  final Future<WebViewController> controller;

  WebViewMenu(this.controller);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.refresh:
                _onRefresh(controller.data, context);
                break;
              case MenuOptions.copyLink:
                _onCopyLink(controller.data, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.refresh,
              child: Text(I18n.of(context).text('refresh')),
            ),
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.copyLink,
              child: Text(I18n.of(context).text('copy_link')),
            ),
          ],
        );
      },
    );
  }

  void _onRefresh(WebViewController controller, BuildContext context) {
    controller.reload();
  }

  void _onCopyLink(WebViewController controller, BuildContext context) async {
    String url = await controller.currentUrl();
    ClipboardUtil.copy(url)
        .then((value) => ToastUtil.show(I18n.of(context).text('copied')));
  }
}
