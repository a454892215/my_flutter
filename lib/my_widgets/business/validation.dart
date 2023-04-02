// 用户名: 需要5-14位字母和数字组合，首位为字母
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../util/Log.dart';

RegExp usernameRegExp = RegExp(r"^[a-zA-Z][a-zA-Z0-9]{4,13}$");

RegExp pswRegExp = RegExp(r"^(?!^\d+$)(?!^[a-zA-Z]+$)[0-9A-Za-z]{8,20}$");
// 手机号正则表达式
final phoneNumExp = RegExp(r"^[1-9]([0-9]{8,8})$");
final upperCaseCharExp = RegExp(r"^[A-Z]$");

final FilteringTextInputFormatter pureNumFormatter = FilteringTextInputFormatter.allow(RegExp("[0-9]"));

bool isUppercaseLetter(String str) {
  if (str.length > 1) {
    Log.e("字符串长度必须是1");
    return false;
  }
  return upperCaseCharExp.hasMatch(str);
}

bool isValidUserName(String name) {
  return usernameRegExp.hasMatch(name);
}

bool isValidPsw(String psw) => pswRegExp.hasMatch(psw);

bool isValidPhoneNum(String phoneNum) => phoneNumExp.hasMatch(phoneNum);

bool isValidVerifyCode(String code) => code.length == 4;

///适用于： 当新增输入当字符出现一个大写字母当时候调用
String inputToLowerCase(String text, TextEditingController controller) {
  int uppercaseLetterIndex = -1;
  for (int i = 0; i < text.length; i++) {
    if (isUppercaseLetter(text[i])) {
      uppercaseLetterIndex = i;
      break;
    }
  }
  Log.d("uppercaseLetterIndex: $uppercaseLetterIndex");
  if (uppercaseLetterIndex >= 0) {
    text = text.toLowerCase();
    controller.text = text;
    controller.selection = TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: uppercaseLetterIndex + 1));
  }
  return text;
}

class InfoValidationHint {
  final EditNode userNameNode = EditNode();
  final EditNode phoneNumNode = EditNode();
  final EditNode pswNode = EditNode();
  final EditNode confirmPswNode = EditNode();
  final EditNode verifyCodeNode = EditNode();

  bool isHasSuccessSendVerifyCode = false;

  void onUserNameChanged(String name) {
    userNameNode.text.value = name;
    checkUserNameInvalid();
  }

  void checkUserNameInvalid() {
    userNameNode.isShowErrHint.value = !usernameRegExp.hasMatch(userNameNode.text.value);
  }

  void checkPswInvalid() {
    pswNode.isShowErrHint.value = !pswRegExp.hasMatch(pswNode.text.value);
  }

  void checkConfirmPswInvalid() {
    confirmPswNode.isShowErrHint.value = pswNode.text.value != confirmPswNode.text.value;
  }

  void checkPhoneNumInvalid() {
    phoneNumNode.isShowErrHint.value = !phoneNumExp.hasMatch(phoneNumNode.text.value);
  }

  void checkVerifyCodeInvalid() {
    verifyCodeNode.isShowErrHint.value = verifyCodeNode.text.value.length != 4;
  }

  void onPhoneNumChanged(String num) {
    phoneNumNode.text.value = num;
    checkPhoneNumInvalid();
  }

  void onPswChanged(String psw) {
    pswNode.text.value = psw;
    checkPswInvalid();
    if (confirmPswNode.text.value.isNotEmpty) {
      checkConfirmPswInvalid();
    }
  }

  void onConfirmPswChanged(String confirmPsw) {
    confirmPswNode.text.value = confirmPsw;
    checkConfirmPswInvalid();
  }

  void onVerifyCodeChanged(String code) {
    verifyCodeNode.text.value = code;
    checkVerifyCodeInvalid();
  }

  void onCommitUserNameAndPhoneNum() {
    checkUserNameInvalid();
    checkPhoneNumInvalid();
  }

  void onCommitPswAndVerifyCode() {
    checkPswInvalid();
    checkConfirmPswInvalid();
    checkVerifyCodeInvalid();
  }
}

class EditNode {
  final FocusNode focusNode = FocusNode();
  final hasFocus = false.obs;
  final TextEditingController editController = TextEditingController();
  final text = "".obs;
  final obscureTextEnable = true.obs;
  final isShowErrHint = false.obs;

  EditNode() {
    focusNode.addListener(() => hasFocus.value = focusNode.hasFocus);
  }
}
