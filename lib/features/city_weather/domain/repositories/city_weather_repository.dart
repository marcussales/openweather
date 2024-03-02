import 'package:either_dart/either.dart';
import 'package:weather_poc_flutter/common/utils/server_error.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/entities/city_weather.dart';

abstract class CityWeatherRepository {
  Future<Either<ServerError, List<CityWeather>>> getCityWeather(String? cityName);
}
