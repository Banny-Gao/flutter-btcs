import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'index.dart';

void showProgress(received, total) {
  if (total != -1) {
    EasyLoading.showProgress(received / total, status: 'progress');
  }
}

// 类型 1:更换手机绑定 2.更新 3.注册,4.手机号登陆，5.密码修改
Future _getCode(phone, type) async {
  final resp = await Request.dio.get(
    '/front/member/sendNote',
    queryParameters: {
      'phone': phone,
      'type': type,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 注册
Future _signUp({phone, password, code, inviteCode}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneRegister',
    data: {
      'phone': phone,
      'password': password,
      'code': code,
      'inviteCode': inviteCode,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 密码登录
Future _passwordSignIn({phone, password}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneLogin',
    data: {
      'phone': phone,
      'password': password,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 短信登录
Future _codeSignIn({phone, code}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneNoteLogin',
    data: {
      'phone': phone,
      'code': code,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 修改密码
Future _changePassword({code, phone, newPassword}) async {
  final resp = await Request.dio.post(
    '/front/member/noteUpdateLogPwd',
    data: {
      'code': code,
      'phone': phone,
      'password': newPassword,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 首页轮播图
Future _getSlides({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/slideshow/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

// 首页公告列表
Future _getBulletins({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/bulletin/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

// 币种列表
Future _getCoinTypes() async {
  final resp = await Request.dio.get(
    '/front/currency/list',
  );

  return resp.data;
}

// 币种资产
Future _getCoinAssets(currencyId) async {
  final resp = await Request.dio.get(
    'front/assets/detail/${currencyId}',
  );

  return resp.data;
}

// 拼团列表
Future _getGroups(currencyId) async {
  final resp = await Request.dio.get(
    '/front/group/list',
    queryParameters: {
      'currencyId': currencyId,
    },
  );

  return resp.data;
}

// 拼团详情
Future _getGroup(id) async {
  final resp = await Request.dio.get('/front/group/detail/$id');

  return resp.data;
}

// 帮助中心分类
Future _getHelpClassifications({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/help/helpClassifylist',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

// 帮助中心列表
Future _getHelps({pageNum = 1, pageSize = 3, helpClassifyId = -1}) async {
  final resp = await Request.dio.get(
    '/front/help/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'helpClassifyId': helpClassifyId,
    },
  );

  return resp.data;
}

// 帮助详情
Future _getHelp(id) async {
  final resp = await Request.dio.get('/front/help/detail/$id');

  return resp.data;
}

// 获取用户信息
Future _getUserInfo() async {
  final resp = await Request.dio.get('/front/member/memberInfo');

  return resp.data;
}

// 修改用户信息
Future _changeUserInfo({memberAvatar, memberName}) async {
  final resp = await Request.dio.post(
    '/front/member/update/info',
    data: {
      'memberAvatar': memberAvatar,
      'memberName': memberName,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 实名认证
Future _userAuth({
  backImage,
  frontImage,
  handheldImage,
  idCardNum,
  name,
  sex,
  validityEndTime,
  validityStartTime,
}) async {
  final resp = await Request.dio.post(
    '/front/realNameApply/save',
    data: {
      'backImage': backImage,
      'frontImage': frontImage,
      'handheldImage': handheldImage,
      'idCardNum': idCardNum,
      'name': name,
      'sex': sex,
      'validityEndTime': validityEndTime,
      'validityStartTime': validityStartTime,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 获取实名认证状态
Future _getUserAuth() async {
  final resp = await Request.dio.get('/front/realNameApply/info');

  return resp.data;
}

// 修改手机号
Future _changePhone({code, memberPhone}) async {
  final resp = await Request.dio.post(
    '/front/member/updatePhone',
    data: {
      'code': code,
      'memberPhone': memberPhone,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 修改支付密码
Future _chagePaymentPassword({code, phone, newPassword}) async {
  final resp = await Request.dio.post(
    '/front/member/noteUpdatePayPwd',
    data: {
      'code': code,
      'phone': phone,
      'password': newPassword,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 获取钱包地址列表
Future _getWalletAddresses({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/walletAddress/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

// 添加钱包地址
Future _addWalletAddress(address, currencyId) async {
  final resp = await Request.dio.get(
    '/front/walletAddress/add',
    queryParameters: {
      'address': address,
      'currencyId': currencyId,
    },
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 更新钱包地址
Future _updateWalletAddress(address, currencyId, id, memberId) async {
  final resp = await Request.dio.post(
    '/front/walletAddress/update',
    queryParameters: {
      'address': address,
      'currencyId': currencyId,
      'id': id,
      'memberId': memberId,
    },
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 删除钱包地址
Future _deleteWalletAddress(id) async {
  final resp = await Request.dio.post('/front/walletAddress/delete/${id}');

  Request.netCache.cache.clear();

  return resp.data;
}

// 提现申请列表
Future _getWithdrawAudits({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/withdrawAudit/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

// 提现申请详情
Future _getWithdrawAudit(id) async {
  final resp = await Request.dio.get('/front/withdrawAudit/detail/${id}');

  return resp.data;
}

// 提现申请
Future _addWithdrawAudit({address, currencyId, money, serviceCharge}) async {
  final resp = await Request.dio.get(
    '/front/withdrawAudit/detail/',
    queryParameters: {
      'address': address,
      'currencyId': currencyId,
      'money': money,
      'serviceCharge': serviceCharge,
    },
  );

  Request.netCache.cache.clear();

  return resp.data;
}

// 获取协议 1用户注册协议 2隐私政策 ，3比特算下单合同协议，4.公司简介
Future _getDeal(type) async {
  final resp = await Request.dio.get(
    '/front/aboutus/findByAboutus',
    queryParameters: {
      'type': type,
    },
  );

  Request.netCache.cache.clear();

  return resp.data;
}

Future _upload(path, fileName) async {
  Future<FormData> getFormData() async => FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(
            path,
            filename: fileName,
          ),
        },
      );

  final resp = await Request.dio.post(
    '/front/oss/upload',
    data: await getFormData(),
    onSendProgress: showProgress,
  );

  Request.netCache.cache.clear();

  return resp.data;
}

class API {
  static final getCode = _getCode;
  static final signUp = _signUp;
  static final passwordSignIn = _passwordSignIn;
  static final codeSignIn = _codeSignIn;
  static final changePassword = _changePassword;
  static final getSlides = _getSlides;
  static final getBulletins = _getBulletins;
  static final getCoinTypes = _getCoinTypes;
  static final getCoinAssets = _getCoinAssets;
  static final getGroups = _getGroups;
  static final getGroup = _getGroup;
  static final getHelpClassifications = _getHelpClassifications;
  static final getHelps = _getHelps;
  static final getHelp = _getHelp;
  static final getUserInfo = _getUserInfo;
  static final chagePaymentPassword = _chagePaymentPassword;
  static final changeUserInfo = _changeUserInfo;
  static final userAuth = _userAuth;
  static final getUserAuth = _getUserAuth;
  static final changePhone = _changePhone;
  static final getWalletAddresses = _getWalletAddresses;
  static final addWalletAddress = _addWalletAddress;
  static final updateWalletAddress = _updateWalletAddress;
  static final deleteWalletAddress = _deleteWalletAddress;
  static final getWithdrawAudits = _getWithdrawAudits;
  static final getWithdrawAudit = _getWithdrawAudit;
  static final addWithdrawAudit = _addWithdrawAudit;
  static final getDeal = _getDeal;
  static final upload = _upload;
}
