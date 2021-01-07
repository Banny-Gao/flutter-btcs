class Re {
  static RegExp phone = new RegExp(r"^1[3|4|5|7|8|9]\d{9}$");

  static RegExp passWord = new RegExp(r"^[~!@#$%^&*\-+=_.0-9a-zA-Z]{6,20}$");

  static RegExp number = new RegExp(r"^[0-9]+.?[0-9]*$");

  static RegExp chineseName =
      new RegExp(r"^[\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$");

  static RegExp idCard = new RegExp(
      r"^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$");
}
