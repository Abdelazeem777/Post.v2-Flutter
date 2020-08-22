import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double _blockSizeHorizontal;
  static double _blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double _safeBlockHorizontal;
  static double _safeBlockVertical;

  static bool longScreen = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = screenWidth / 100;
    _blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    _safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    _safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    print(screenHeight);
    checkScreenHeight();
  }

  static double get blockSizeHorizontal {
    return _blockSizeHorizontal;
  }

  static double get blockSizeVertical {
    return longScreen ? _blockSizeVertical * 1.2 : _blockSizeVertical;
  }

  static double get safeBlockHorizontal {
    return _safeBlockHorizontal;
  }

  static double get safeBlockVertical {
    return longScreen ? _safeBlockVertical * 1.2 : _safeBlockVertical;
  }

  void checkScreenHeight() => longScreen = screenHeight > 605;
}
