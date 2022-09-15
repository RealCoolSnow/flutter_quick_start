import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_quick_start/constant/asset_images.dart';
import 'package:flutter_quick_start/ui/app_theme.dart';
import 'package:flutter_quick_start/ui/page/home/tab1.dart';
import 'package:flutter_quick_start/ui/page/home/tab2.dart';
import 'package:flutter_quick_start/ui/page/home/tab3.dart';
import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContainerPageState();
  }
}

class _TabItem {
  late String name, activeIcon, normalIcon;
  _TabItem(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerPageState extends State<ContainerPage> {
  final defaultItemColor = Color.fromARGB(255, 125, 125, 125);
  List<Widget> pages = [Tab1(), Tab2(), Tab3()];
  final itemNames = [
    _TabItem('tab.home'.tr(), AssetImages.TAB_HOME_ACTIVE,
        AssetImages.TAB_HOME_NORMAL),
    _TabItem('tab.circle'.tr(), AssetImages.TAB_CIRCLE_ACTIVE,
        AssetImages.TAB_CIRCLE_NORMAL),
    _TabItem(
        'tab.me'.tr(), AssetImages.TAB_ME_ACTIVE, AssetImages.TAB_ME_NORMAL)
  ];
  List<BottomNavigationBarItem> itemList = [];
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    if (itemList.length <= 0) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 30.0,
                height: 30.0,
              ),
              // title: Text(
              //   item.name,
              //   style: TextStyle(fontSize: 10.0),
              // ),
              label: item.name,
              activeIcon:
                  Image.asset(item.activeIcon, width: 30.0, height: 30.0)))
          .toList();
    }
  }

//Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: new Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          ///这里根据点击的index来显示，非index的page均隐藏
          setState(() {
            _selectIndex = index;
            // //这个是用来控制比较特别的shopPage中WebView不能动态隐藏的问题
            // shopPageWidget
            //     .setShowState(pages.indexOf(shopPageWidget) == _selectIndex);
          });
        },
        //图标大小
        iconSize: 24,
        //当前选中的索引
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: AppTheme.primary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('app_name'.tr()),
      actions: <Widget>[],
      // bottom: _buildTabBar(),
    );
  }
}
