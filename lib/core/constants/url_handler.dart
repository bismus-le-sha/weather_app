class Urls {
  static const String baseUrl = 'http://api.weatherapi.com/v1/current.json?';
  static const String apiKey = String.fromEnvironment('WEATHER_API_KEY');
  static String currentWeatherByName(String city) =>
      '${baseUrl}key=$apiKey&q=$city&lang=ru';
  static String weatherConditionList(String iconCode) =>
      'https://www.weatherapi.com/docs/conditions.json';
  static String locationByName(String query) =>
      'https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query';
}
