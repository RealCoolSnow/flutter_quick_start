import 'package:flutter_quick_start/common_libs.dart';
import 'package:flutter_quick_start/ui/common/app_scroll_behavior.dart';

class AppScaffold extends StatelessWidget with GetItMixin {
  AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
          data: $styles.colors.toThemeData(),
          // Provide a default texts style to allow Hero's to render text properly
          child: DefaultTextStyle(
            style: $styles.text.body,
            // Use a custom scroll behavior across entire app
            child: ScrollConfiguration(
              behavior: AppScrollBehavior(),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
