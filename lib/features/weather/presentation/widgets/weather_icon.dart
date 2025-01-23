import 'package:flutter/widgets.dart';

Widget getWeatherIcon(int conditionCode, int isDay) {
  switch (conditionCode) {
    case 1000:
      return isDay == 1
          ? Image.asset('assets/images/sun.png')
          : Image.asset('assets/images/clear-night.png');
    case 1003 || 1006:
      return isDay == 1
          ? Image.asset('assets/images/cloudy-day.png')
          : Image.asset('assets/images/cloudy-night.png');
    case 1063 || 1150 || 1153 || 1168 || 1072 || 1180 || 1183 || 1198 || 1240:
      return isDay == 1
          ? Image.asset('assets/images/rainy-day.png')
          : Image.asset('assets/images/rainy-night.png');
    case 1087:
      return Image.asset('assets/images/cloudy_thunder.png');
    case 1066 || 1069 || (>= 1204 && <= 1225) || 1255 || 1258 || 1279 || 1282:
      return Image.asset('assets/images/snowfall.png');
    case 1273 || 1276:
      return isDay == 1
          ? Image.asset('assets/images/thunder-storm-day.png')
          : Image.asset('assets/images/thunder-storm-night.png');
    case 1168 || 1171 || (>= 1186 && <= 1195) || 1201:
      return Image.asset('assets/images/rain.png');
    case 1009:
      return Image.asset('assets/images/cloudy.png');
    default:
      return Image.asset('assets/images/windy-rain.png');
  }
}
