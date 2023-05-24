

import 'package:flutter/cupertino.dart';

class ScreenSizeQuery {


  static const int isMobile = 1;
  static const int isTablet = 2;
  static const int isDesktop = 3;





  static int getDeviceType(BuildContext context){
    var width = MediaQuery.of(context).size.width;

    if (width < 800){
      return ScreenSizeQuery.isMobile;
    } else if (width > 800 && width < 1100 ) {
      return ScreenSizeQuery.isTablet;
    } else {
      return ScreenSizeQuery.isDesktop;
    }
  }

}