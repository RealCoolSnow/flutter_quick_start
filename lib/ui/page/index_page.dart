import 'package:flutter_quick_start/common_libs.dart';
import 'package:flutter_quick_start/main.dart';
import 'package:flutter_quick_start/ui/page/tabs/tab1.dart';
import 'package:flutter_quick_start/ui/page/tabs/tab2.dart';
import 'package:flutter_quick_start/ui/page/tabs/tab3.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}

class _TabItem {
  late String name, activeIcon, normalIcon;
  _TabItem(this.name, this.activeIcon, this.normalIcon);
}

class _IndexPageState extends State<IndexPage> {
  int _tabIndex = 0;
  var tabIcons;
  final List<Widget> tabBodies = [Tab1(), Tab2(), Tab3()];
  final tabNames = ['tab.home', 'tab.circle', 'tab.me'];

  Image loadTabIcon(path) {
    return Image.asset(path, width: 25.0, height: 25.0);
  }

  void initData() {
    tabIcons = [
      [
        loadTabIcon(ImageFiles.tab_home_normal),
        loadTabIcon(ImageFiles.tab_home_active)
      ],
      [
        loadTabIcon(ImageFiles.tab_circle_normal),
        loadTabIcon(ImageFiles.tab_circle_active)
      ],
      [
        loadTabIcon(ImageFiles.tab_me_normal),
        loadTabIcon(ImageFiles.tab_me_active),
      ]
    ];
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabIcons[curIndex][1];
    }
    return tabIcons[curIndex][0];
  }

  @override
  void initState() {
    super.initState();
    initData();
    userLogic.doLoginIfUnLogin();
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
          icon: getTabIcon(0), label: AppLocale.t(tabNames[0])),
      BottomNavigationBarItem(
          icon: getTabIcon(1), label: AppLocale.t(tabNames[1])),
      BottomNavigationBarItem(
          icon: getTabIcon(2), label: AppLocale.t(tabNames[2])),
    ];
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            items: bottomTabs,
            onTap: (index) async {
              _tabIndex = index;

              setState(() {
                //  _tabIndex = index;
                //  currentPage = tabBodies[_tabIndex];
              });
            },
          ),
          body: IndexedStack(
            index: _tabIndex,
            children: tabBodies,
          ),
        ),
        onWillPop: () {
          // // 点击返回键的操作
          // if (lastPopTime == null ||
          //     DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          //   lastPopTime = DateTime.now();
          //   ToastUtil.show('再按一次退出应用');
          // } else {
          //   lastPopTime = DateTime.now();
          //   // 退出app
          //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // }
          return Future(() => true);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppLocale.t('app_name')),
      actions: <Widget>[],
      // bottom: _buildTabBar(),
    );
  }
}
