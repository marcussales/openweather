import 'package:either_dart/either.dart';
import 'package:weather_poc_flutter/common/utils/server_error.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/entities/city_weather.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/repositories/city_weather_repository.dart';

abstract class GetCityWeatherUseCase {
  Future<Either<ServerError, List<CityWeather>>> getCityWeather(String? cityName);
}

class GetCityWeatherUseCaseImpl extends GetCityWeatherUseCase {
  final CityWeatherRepository repository;

  GetCityWeatherUseCaseImpl(this.repository);

  @override
  Future<Either<ServerError, List<CityWeather>>> getCityWeather(String? cityName) {
    return repository.getCityWeather(cityName);
  }
}
