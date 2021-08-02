/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 18:28:03
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:24:51
 */
import 'package:dio/dio.dart';
import 'package:flutter_quick_start/config/config.dart';
import 'package:flutter_quick_start/util/log_util.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"app": Config.app});
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Config.debug) {
      logUtil.d('onResponse: ' + response.data.toString());
    }
    super.onResponse(response, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Config.debug) {
      logUtil.d(err.toString());
    }
    super.onError(err, handler);
  }
}
