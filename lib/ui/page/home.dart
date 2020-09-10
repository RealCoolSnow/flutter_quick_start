/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 18:56:21
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 18:25:31
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/config/config.dart';
import 'package:flutter_easy/config/route/routes.dart';
import 'package:flutter_easy/locale/i18n.dart';
import 'package:flutter_easy/service/http/http_util.dart';
import 'package:flutter_easy/ui/widget/shimmer.dart';
import 'package:flutter_easy/ui/widget/smart_drawer.dart';
import 'package:flutter_easy/util/log_util.dart';
import 'package:flutter_easy/util/time_util.dart';
import 'package:flutter_easy/util/toast_util.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),

        ///to disable slide slip
        ///drawerEdgeDragWidth: 0.0,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(I18n.of(context).text('app_name')),
      actions: <Widget>[],
      bottom: _buildTabBar(),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.change_history)),
        Tab(icon: Icon(Icons.face)),
      ],
    );
  }

  Widget _buildDrawer() {
    return SmartDrawer(
      callback: (isOpened) => {logUtil.d('drawerCallback $isOpened')},
      widthPercent: 0.6,
      child: ListView(
        /// set padding for status bar color
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('A',
                      style: TextStyle(color: Colors.purple, fontSize: 30)),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(I18n.of(context).text('about')),
            onTap: _showAbout,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(children: [HomeTab(), Tab2(), Tab3()]);
  }

  void _handlerDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  void _showAbout() {
    _closeDrawer();
    Config.router
        .navigateTo(context, Routes.about, transition: TransitionType.fadeIn);
  }
}

class HomeTab extends StatelessWidget {
  var _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
        child: Column(
      children: [
        RaisedButton(onPressed: _showNow, child: Text('Toast')),
        RaisedButton(onPressed: _showWebView, child: Text('WebView')),
        RaisedButton(onPressed: _httpTest, child: Text('Http Test'))
      ],
    ));
  }

  void _showNow() {
    String now = TimeUtil.format(DateTime.now());
    logUtil.d(now);
    ToastUtil.show(now);
  }

  void _showWebView() {
    final url = Uri.encodeComponent('https://www.baidu.com');
    const title = 'this is title';
    Config.router
        .navigateTo(_context, Routes.webview + "?url=$url&title=$title");
  }

  void _httpTest() {
    HttpUtil()
        .get('/', getParams: {"user": "coolsnow"})
        .then((value) => ToastUtil.show(value.toString()))
        .catchError((error) => {ToastUtil.show(error.msg)});
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Image(
                image: AssetImage('assets/images/avatar.jpg'),
                width: 180,
                height: 180)));
  }
}

class Tab3 extends StatefulWidget {
  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: _enabled,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    _enabled = !_enabled;
                  });
                },
                child: Text(
                  _enabled ? 'Stop' : 'Play',
                  style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 18.0,
                      color: _enabled ? Colors.red : Colors.blue),
                )),
          )
        ],
      ),
    );
  }
}
