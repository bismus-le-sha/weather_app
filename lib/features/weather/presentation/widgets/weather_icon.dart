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
    case 1009:
      return Image.asset('assets/images/cloudy.png');
    case 1030 || 1135 || 1147:
      return isDay == 1
          ? Image.asset('assets/images/fog-day.png')
          : Image.asset('assets/images/fog-night.png');
    case 1063 || 1150 || 1153 || 1168 || 1072 || 1180 || 1183 || 1198 || 1240:
      return isDay == 1
          ? Image.asset('assets/images/rainy-day.png')
          : Image.asset('assets/images/rainy-night.png');
    case 1087:
      return Image.asset('assets/images/cloudy_thunder.png');
    case 1066 || 1069 || (>= 1204 && <= 1225) || 1255 || 1258:
      return Image.asset('assets/images/snowfall.png');
    case 1114 || 1117:
      return isDay == 1
          ? Image.asset('assets/images/blizzard-day.png')
          : Image.asset('assets/images/blizzard-night.png');
    case 1168 || 1171 || (>= 1186 && <= 1195) || 1201:
      return Image.asset('assets/images/rain.png');
    case 1237 || 1261:
      return isDay == 1
          ? Image.asset('assets/images/ice-pellets-day.png')
          : Image.asset('assets/images/ice-pellets-night.png');
    case 1249 || 1252:
      return isDay == 1
          ? Image.asset('assets/images/snowy-rain-day.png')
          : Image.asset('assets/images/snowy-rain-night.png');
    case 1264:
      return Image.asset('assets/images/ice-pellets.png');
    case 1273 || 1276:
      return isDay == 1
          ? Image.asset('assets/images/thunder-storm-day.png')
          : Image.asset('assets/images/thunder-storm-night.png');
    case 1279 || 1282:
      return isDay == 1
          ? Image.asset('assets/images/thunder-snow-day.png')
          : Image.asset('assets/images/thunder-snow-night.png');
    default:
      return Image.asset('assets/images/windy-rain.png');
  }
}
