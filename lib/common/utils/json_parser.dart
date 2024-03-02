import 'package:weather_poc_flutter/features/city_weather/data/models/city_weather_model.dart';

mixin JsonParser {
  static T toModel<T>(Map<String, dynamic> body, Function contentFactory) {
    return contentFactory(body);
  }

  static List<T> toModelList<T>(List<dynamic> body, T Function(Map<String, dynamic>) contentFactory) {
    return body.map((element) => contentFactory(element)).toList();
  }

  static List<CityWeatherModel> toModelStripedList(List<dynamic> response) {
    final List<CityWeatherModel> forecasts = [];
    final Map<String, List> groupedData = {};

    for (var item in response) {
      final dt = DateTime.parse(item['dt_txt']);
      final date = DateTime(dt.year, dt.month, dt.day);
      final dateString = date.toString();

      groupedData.putIfAbsent(dateString, () => []).add(item);
    }

    groupedData.forEach((key, value) {
      final averageTemp = (value.fold(0.0, (sum, item) => sum + item['main']['temp']) / value.length).round();
      final tempMin =
          value.map((item) => item['main']['temp_min']).reduce((a, b) => a < b ? a : b)?.floor();
      final tempMax =
          value.map((item) => item['main']['temp_max']).reduce((a, b) => a > b ? a : b)?.round();
      final weatherDescription = value.first['weather'][0]['description'];
      final icon = 'http://openweathermap.org/img/wn/${value.first['weather'][0]['icon']}.png';

      forecasts.add(CityWeatherModel(
        averageTemperature: averageTemp,
        temperatureMin: tempMin,
        temperatureMax: tempMax,
        weatherDescription: weatherDescription,
        iconCode: icon,
      ));
    });

    return forecasts.take(5).toList();
  }
}
