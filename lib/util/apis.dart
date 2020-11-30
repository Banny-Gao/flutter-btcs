import 'index.dart';
import 'package:dio/dio.dart';
import '../scopedModels/index.dart' as ScopedModels;
import '../models/index.dart' as Models;

Future<Models.User> _signUp({phone, password, code, inviteCode}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneRegister',
    data: {
      'phone': phone,
      'password': password,
      'code': code,
      'inviteCode': inviteCode,
    },
  );

  Request.netCache.cache.clear();

  print(resp);
  // ScopedModels.ProfileModel.profile.token = resp.data;

  return Models.User.fromJson(resp.data);
}

class API {
  static final signUp = _signUp;
}
