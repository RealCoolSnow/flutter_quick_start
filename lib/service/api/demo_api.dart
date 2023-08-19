import 'package:flutter_quick_start/model/user_info_model.dart';

import '../../model/base/base_resp.dart';
import '../http/http_util.dart';

class DemoApi {
  Future<BaseResp<UserInfoModel>> getUserInfo() async {
    var json = await HttpUtil().post('/userinfo', {});
    return BaseResp<UserInfoModel>.fromJson(json, (data) => data);
  }
}
