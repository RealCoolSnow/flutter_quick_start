/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 18:56:21
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:57:44
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/config/config.dart';
import 'package:flutter_easy/config/route/routes.dart';
import 'package:flutter_easy/locale/i18n.dart';
import 'package:flutter_easy/service/http/http_util.dart';
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

  void _showAbout() {
    Config.router
        .navigateTo(context, Routes.about, transition: TransitionType.fadeIn);
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        RaisedButton(onPressed: showNow, child: Text('Toast')),
        RaisedButton(onPressed: httpTest, child: Text('Http Test'))
      ],
    ));
  }

  void showNow() {
    String now = TimeUtil.format(DateTime.now());
    logUtil.d(now);
    ToastUtil.show(now);
  }

  void httpTest() {
    HttpUtil()
        .get('/', getParams: {"user": "coolsnow"})
        .then((value) => ToastUtil.show(value.toString()))
        .catchError((error) => {ToastUtil.show(error.msg)});
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("tab2")));
  }
}

class Tab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("tab3")));
  }
}
