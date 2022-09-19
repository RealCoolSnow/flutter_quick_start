import 'dart:core';
import 'dart:async';
import 'package:flutter_quick_start/assets.dart';
import 'package:flutter_quick_start/common_libs.dart';
import 'package:flutter_quick_start/ui/page/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final int seconds;
  const SplashPage({super.key, required this.seconds});
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var container = HomePage();
  bool showAd = true;

  @override
  void initState() {
    super.initState();
    if (widget.seconds <= 0) {
      setState(() {
        showAd = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(ImageFiles.splash),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Nice to meet you.',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment(1.0, 0.0),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                        child: CountDownWidget(
                            onCountDownFinishCallBack: (bool value) {
                              if (value) {
                                setState(() {
                                  showAd = false;
                                  appRouter.go(PagePaths.home);
                                });
                              }
                            },
                            seconds: widget.seconds),
                        decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            ImageFiles.avatar,
                            width: 50.0,
                            height: 50.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Hello',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
            // width: ScreenUtil().screenWidth,
            // height: ScreenUtil().screenHeight,
          ),
          offstage: !showAd,
        )
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final onCountDownFinishCallBack;
  var seconds;
  CountDownWidget(
      {Key? key, @required this.onCountDownFinishCallBack, this.seconds})
      : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late Timer _timer;

  _CountDownWidgetState();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.seconds}',
      style: TextStyle(fontSize: 17.0),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (widget.seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      widget.seconds--;
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }
}
