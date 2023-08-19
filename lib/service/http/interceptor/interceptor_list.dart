/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 18:28:03
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:24:51
 */
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_quick_start/constant/constant.dart';
import 'package:flutter_quick_start/util/log_util.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"app": Constant.app});
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Constant.debug) {
      logUtil.d('onResponse: ' + response.data.toString());
    }
    super.onResponse(response, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Constant.debug) {
      logUtil.d(err.toString());
    }
    super.onError(err, handler);
  }
}

// cache interceptor
// Global options
final cacheOptions = CacheOptions(
  // A default store is required for interceptor.
  store: MemCacheStore(),
  // All subsequent fields are optional.
  // Default.
  policy: CachePolicy.request,
  // Returns a cached response on error but for statuses 401 & 403.
  // Also allows to return a cached response on network errors (e.g. offline usage).
  // Defaults to [null].
  hitCacheOnErrorExcept: [401, 403],
  // Overrides any HTTP directive to delete entry past this duration.
  // Useful only when origin server has no cache config or custom behaviour is desired.
  // Defaults to [null].
  maxStale: const Duration(days: 7),
  // Default. Allows 3 cache sets and ease cleanup.
  priority: CachePriority.normal,
  // Default. Body and headers encryption with your own algorithm.
  cipher: null,
  // Default. Key builder to retrieve requests.
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  // Default. Allows to cache POST requests.
  // Overriding [keyBuilder] is strongly recommended when [true].
  allowPostMethod: false,
);