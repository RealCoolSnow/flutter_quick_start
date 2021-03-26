/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 17:32:48
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 11:58:01
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
/// add calback for Drawer
///
///
class SmartDrawer extends StatefulWidget {
  final double elevation;
  final Widget? child;
  final String semanticLabel;
  final double widthPercent;
  final DrawerCallback? callback;
  const SmartDrawer({
    Key? key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel = "",
    this.widthPercent = 0.5,
    this.callback,
  })  : assert(widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);
  @override
  _SmartDrawerState createState() => _SmartDrawerState();
}

class _SmartDrawerState extends State<SmartDrawer> {
  @override
  void initState() {
    if (widget.callback != null) {
      widget.callback!(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.callback != null) {
      widget.callback!(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = widget.semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = widget.semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        // label = (widget.semanticLabel ??
        //     MaterialLocalizations.of(context)?.drawerLabel)!;
        label = widget.semanticLabel;
        break;
    }
    final double _width =
        MediaQuery.of(context).size.width * widget.widthPercent;
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          elevation: widget.elevation,
          child: widget.child,
        ),
      ),
    );
  }
}
