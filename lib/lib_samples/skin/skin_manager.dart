import 'package:my_flutter_lib_3/lib_samples/skin/base_skin.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/black_skin.dart';
import 'package:my_flutter_lib_3/lib_samples/skin/bright_skin.dart';

class Skin {
  SkinType _curSkinType = SkinType.bright;

  void changeSink(SkinType type) {
    _curSkinType = type;
  }

  BaseSkin getSkin() => _curSkinType.getSkin();
}

Skin globalSkin = Skin();

BaseSkin skin() {
  return globalSkin.getSkin();
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
