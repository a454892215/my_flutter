import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/base_skin.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/black_skin.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/bright_skin.dart';

class Skin {
  SkinType _curSkinType = SkinType.bright;
  Callback? onSystemThemeChangeListener;

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
