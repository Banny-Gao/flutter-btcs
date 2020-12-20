final BaseUrl = "http://47.93.123.178:9099/api/";

class Tips {
  static const codeErrorText = "验证码格式有误";
  static String phoneErrorText = "手机号格式有误";
  static String passwordErrorText = "请输入6-20位密码";
  static String passwordRepeatErrorText = "两次密码输入不一致";
  static String signUpCodeSendSuccess = "短信发送成功，请注意查收";
  static String userNameErrorText = "昵称不能为空";
  static String choiceCoinEmpty = "请选择币种";
}

List AuthStates = ['未认证', '待审核', '审核拒绝', '已认证'];

List PaymentPasswordStates = ['未设置', '已设置'];

List GroupState = ['距拼团开始: ', '距拼团结束: ', '拼团结束', '已售空'];

List OrdersStatus = ['待支付', '支付成功', '已取消', '已完成', '审核中'];

List RobotStatus = ['关机中', '正在挖矿'];

List CauseStatus = ['个人取消', '订单超时', '支付失败'];

List EnergyStatus = ['已欠费', '正常'];
