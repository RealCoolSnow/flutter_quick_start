import 'package:flutter_quick_start/common_libs.dart';
import 'package:flutter_quick_start/ui/common/themed_text.dart';

class IntroPage extends StatefulWidget {
  _IntroPageState createState() => new _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    appRouter.go(PagePaths.home);
    settingsLogic.hasCompletedOnboarding.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextColor(
      color: $styles.colors.offWhite,
      child: Container(
        color: $styles.colors.black,
        child: SafeArea(child: Text('IntroPage')
            //content.animate().fadeIn(delay: 500.ms)
            ),
      ),
    );
  }
}
