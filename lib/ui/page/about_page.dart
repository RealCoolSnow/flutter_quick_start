import 'package:flutter_quick_start/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/ui/widget/draggable_card.dart';

class AboutPage extends StatefulWidget {
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text($locale.t('about')),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Hero(
              tag: 'myhero',
              child: const DraggableCard(
                  child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                radius: 120,
              ))),
        ));
  }
}
