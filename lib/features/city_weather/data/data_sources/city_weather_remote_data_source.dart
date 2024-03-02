import 'package:weather_poc_flutter/common/config/app_http_client.dart';
import 'package:weather_poc_flutter/common/utils/json_parser.dart';
import 'package:weather_poc_flutter/features/city_weather/data/models/city_weather_model.dart';

abstract class CityWeatherRemoteDataSource {
  Future<List<CityWeatherModel>> getCityWeather(String? cityName);
}

class CityWeatherRemoteDataSourceImpl extends CityWeatherRemoteDataSource {
  final AppHttpService _httpClient;
  CityWeatherRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<CityWeatherModel>> getCityWeather(String? cityName) async {
    final response = await _httpClient.get('?q=$cityName');
    return JsonParser.toModelStripedList(response['list']);
  }
}
