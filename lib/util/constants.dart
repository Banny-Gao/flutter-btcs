final BaseUrl = "http://47.93.123.178:9099/api/";
final BaseSocketUrl = "http://47.93.123.178:9099/api/market-ws";

class Tips {
  static const codeErrorText = "验证码格式有误";
  static String phoneErrorText = "手机号格式有误";
  static String passwordErrorText = "请输入6-20位密码";
  static String passwordRepeatErrorText = "两次密码输入不一致";
  static String signUpCodeSendSuccess = "短信发送成功，请注意查收";
  static String userNameErrorText = "昵称不能为空";
  static String choiceCoinEmpty = "请选择币种";
  static String idCardErrorText = "身份证号码格式有误";
  static String nameErrorText = "姓名不能空";
  static String isCardDateStartError = "有效期开始时间不能为空";
  static String isCardDateEndError = "有效期结束时间不能为空";
  static String btcAddressErrorText = "BTC提现地址不能为空";
  static String ethAddressErrorText = "ETH提现地址不能为空";
  static String usdtAddressErrorText = "USDT提现地址不能为空";
}

List AuthStates = ['未认证', '待审核', '审核拒绝', '已认证'];

List PaymentPasswordStates = ['未设置', '已设置'];

List GroupState = ['距拼团开始: ', '距拼团结束: ', '拼团结束', '已售空'];

List OrdersStatus = ['待支付', '支付成功', '已取消', '已完成', '审核中'];

List RobotStatus = ['关机中', '正在挖矿'];

List CauseStatus = ['个人取消', '订单超时', '支付失败'];

List EnergyStatus = ['已欠费', '正常'];

List ElectricOrderStatus = ['待支付', '待审核', '已取消', '支付成功'];

List AessetTypes = ['矿机收益'];

List WithdrawStatus = ['等待处理', '通过', '拒绝'];
