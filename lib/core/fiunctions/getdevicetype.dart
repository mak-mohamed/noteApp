

import 'package:flutter/cupertino.dart';

enum DeviceType { mopile, tablet, pc }

DeviceType getDeviceType(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = 0;
  if (orientation == Orientation.landscape) {
    width = mediaQueryData.size.height;
  } else {
    width = mediaQueryData.size.width;
  }
  if (width >= 950) {
    return DeviceType.pc;
  } else if (width >= 600) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mopile;
  }
}
