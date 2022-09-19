import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quick_start/common_libs.dart';

class HooksPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    useEffect(() {
      LogUtil().d('useEffect');
    }, []);
    return Scaffold(
        appBar: AppBar(
          title: const Text('hooks'),
        ),
        body: Center(
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () => counter.value++,
                  child: Text('useState: ${counter.value}'),
                )),
          ]),
        ));
  }
}
