/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 18:56:21
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 16:04:30
 */
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/config/config.dart';
import 'package:flutter_quick_start/config/route/routes.dart';
import 'package:flutter_quick_start/locale/i18n.dart';
import 'package:flutter_quick_start/ui/page/home/tab1.dart';
import 'package:flutter_quick_start/ui/page/home/tab2.dart';
import 'package:flutter_quick_start/ui/page/home/tab3.dart';
import 'package:flutter_quick_start/ui/widget/smart_drawer.dart';
import 'package:flutter_quick_start/util/log_util.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _selectedIndex,
            showElevation: false,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.change_history),
                  title: Text('Create'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: Icon(Icons.face),
                  title: Text('Me'),
                  activeColor: Colors.blueAccent),
            ],
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(I18n.of(context).text('app_name')),
      actions: <Widget>[],
      // bottom: _buildTabBar(),
    );
  }

  TabBar _buildTabBar() {
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
    return PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: <Widget>[Tab1(), Tab2(), Tab3()]);
  }

  // Widget _buildBody() {
  //   return TabBarView(children: [Tab1(), Tab2(), Tab3()]);
  // }

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
