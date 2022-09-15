/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 18:16:14
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:25:03
 */
import 'package:dio/dio.dart';
import 'package:flutter_quick_start/constant/constant.dart';
import 'package:flutter_quick_start/service/http/util/full_url.dart';
import 'package:flutter_quick_start/service/http/http_config.dart';
import 'package:flutter_quick_start/service/http/util/http_error.dart';
import 'package:flutter_quick_start/service/http/util/http_exception.dart';
import 'package:flutter_quick_start/service/http/interceptor/interceptor_list.dart';

/// Usage:
///
/// HttpUtil()
///     .get('/', getParams: {"user": "coolsnow"})
///     .then((value) => ToastUtil.show(value.toString()))
///     .catchError((error) => {ToastUtil.show(error.msg)});
///
/// !!important
/// The server response should follow this format:
/// {
///   "code": 0,
///   "msg": "OK",
///   "data": {}
/// }
///
class HttpUtil {
  static final HttpUtil _instance = new HttpUtil._internal();
  static const String GET = "get";
  static const String POST = "post";
  static const String UPLOAD = "upload";
  late Dio _dio;
  late BaseOptions _baseOption;
  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    _baseOption = BaseOptions(
        contentType: HttpConfig.contentType.value,
        connectTimeout: HttpConfig.connectTimeout,
        receiveTimeout: HttpConfig.receiveTimeout,
        baseUrl: HttpConfig.baseUrl);
    _dio = new Dio(_baseOption);
    if (Constant.debug) {
      addInterceptor(LogInterceptor());
    }
    addInterceptor(HeaderInterceptor());
    addInterceptor(ErrorInterceptor());
  }
  addInterceptor(Interceptor interceptor) {
    if (null != _dio) {
      _dio.interceptors.add(interceptor);
    }
  }

  /// get
  Future<dynamic> get(String path, {Map<String, String>? getParams}) {
    return request(path, GET, getParams: getParams);
  }

  /// post
  Future<dynamic> post(String path, postData) {
    return request(path, POST, postData: postData);
  }

  /// upload
  Future<dynamic> upload(String path, postData) {
    return request(path, UPLOAD, postData: postData);
  }

  Future<dynamic> request(String path, String mode,
      {postData, Map<String, String>? getParams}) async {
    try {
      bool isExternalRequest = !path.contains(_baseOption.baseUrl);
      path = isExternalRequest ? path : FullUrl.make(path, getParams);
      var resp;
      switch (mode) {
        case GET:
          resp = await _dio.get(path);
          break;
        case POST:
          resp = await _dio.post<Map<String, dynamic>>(path, data: postData);
          break;
        case UPLOAD:
          resp = await _dio.post(path, data: postData);
          break;
      }
      if (isExternalRequest)
        return resp.data;
      else
        return resp.data['code'] != 0
            ? Future.error(HttpException(resp.data['code'], resp.data['msg']))
            : resp.data['data'];
    } on DioError catch (e) {
      int code = HttpError.UNKNOWN;
      if (e.response != null && e.response!.statusCode != null) {
        code = e.response!.statusCode!;
      }
      return Future.error(HttpException(code, e.message));
    } catch (e) {
      return Future.error(HttpException(HttpError.EXCEPTION, e.toString()));
    }
  }
}
