import 'package:flutter_quick_start/common_libs.dart';
import 'package:flutter_quick_start/ui/app_scaffold.dart';
import 'package:flutter_quick_start/ui/page/about_page.dart';
import 'package:flutter_quick_start/ui/page/home_page.dart';
import 'package:flutter_quick_start/ui/page/hooks_page.dart';
import 'package:flutter_quick_start/ui/page/intro_page.dart';
import 'package:flutter_quick_start/ui/page/splash_page.dart';
import 'package:flutter_quick_start/ui/webview/webview.dart';
import 'package:flutter/cupertino.dart';

class PagePaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String about = '/about';
  static String hooks = '/hooks';
  static String webview(String url, {String title = ''}) =>
      '/webview/$url?title=$title';
}

final appRouter = GoRouter(
  redirect: _handleRedirect,
  routes: [
    AppRoute(
        PagePaths.splash, (_) => SplashPage(seconds: 3)), // This will be hidden
    AppRoute(PagePaths.intro, (_) => IntroPage()),
    AppRoute(PagePaths.home, (_) => HomePage()),
    AppRoute(PagePaths.about, (_) => AboutPage()),
    AppRoute(PagePaths.hooks, (_) => HooksPage()),
    AppRoute('/webview/:url', (s) {
      String title = s.queryParams['title'] ?? '';
      return WebViewPage(url: s.params['url']!, title: title);
    }),
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != PagePaths.splash) {
    return PagePaths.splash;
  }
  logUtil.d('Navigate to: ${state.location}');
  return null; // do nothing
}
