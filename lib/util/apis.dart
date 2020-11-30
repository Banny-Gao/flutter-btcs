import 'package:dio/dio.dart';
import 'index.dart';
import '../scopedModels/index.dart' as ScopedModels;
import '../models/index.dart' as Models;

Future<Models.User> _signUp({phone, password, code, inviteCode}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneRegister',
    data: FormData.fromMap({
      phone: phone,
      password: password,
      code: code,
      inviteCode: inviteCode,
    }),
  );

  Request.netCache.cache.clear();
  ScopedModels.ProfileModel.profile.token = resp.data;

  print(resp);
  return Models.User.fromJson(resp.data);
}

class API {
  static final signUp = _signUp;
}
