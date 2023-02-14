import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/base_skin.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/black_skin.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/bright_skin.dart';

import '../../util/Log.dart';

class Skin {
  SkinType _curSkinType = SkinType.bright;
  Callback? onSystemThemeChangeListener;
  Brightness? curSystemTheme;

  void changeSink(SkinType type) {
    _curSkinType = type;
  }

  BaseSkin getSkin() => _curSkinType.getSkin();

  void onSystemThemeChange() {
    if (onSystemThemeChangeListener != null) {
      onSystemThemeChangeListener!();
    }
  }
}

Skin _skin = Skin();

Skin get globalSkin => _skin;

BaseSkin skin() {
  return _skin.getSkin();
}

void changeSink(SkinType type, {isFromSystem = false}) {
  _skin.changeSink(type);
  if (isFromSystem) {
    _skin.onSystemThemeChange();
  }
}

void switchSink() {
  SkinType type = _skin._curSkinType == SkinType.bright ? SkinType.black : SkinType.bright;
  _skin.changeSink(type);
}

void addOnSystemThemeChangeListener(Callback onSystemThemeChangeListener) {
  _skin.onSystemThemeChangeListener = onSystemThemeChangeListener;
}

void syncSystemThemeMode(BuildContext context) {
  Brightness brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;
  if (_skin.curSystemTheme != brightness) {
    Log.d("当前系统主题模式： themeMode: $brightness");
    if (brightness == Brightness.light) {
      changeSink(SkinType.bright, isFromSystem: true);
    } else if (brightness == Brightness.dark) {
      changeSink(SkinType.black, isFromSystem: true);
    } else {
      Log.e("未知的系统主题模式");
    }
    _skin.curSystemTheme = brightness;
  } else {
    Log.w("主题相同:$brightness");
  }
}

BaseSkin _brightSkin = BrightSkin();
BaseSkin _blackSkin = BlackSkin();

enum SkinType {
  bright,
  black;

  BaseSkin getSkin() {
    switch (this) {
      case bright:
        return _brightSkin;
      case black:
        return _blackSkin;
      default:
        return _brightSkin;
    }
  }
}
