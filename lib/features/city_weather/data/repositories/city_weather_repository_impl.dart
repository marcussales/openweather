import 'package:either_dart/src/either.dart';
import 'package:weather_poc_flutter/common/utils/server_error.dart';
import 'package:weather_poc_flutter/features/city_weather/data/data_sources/city_weather_remote_data_source.dart';
import 'package:weather_poc_flutter/features/city_weather/data/models/city_weather_model.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/entities/city_weather.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/repositories/city_weather_repository.dart';

class CityWeatherRepositoryImpl extends CityWeatherRepository {
  final CityWeatherRemoteDataSource remoteDataSource;
  CityWeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ServerError, List<CityWeather>>> getCityWeather(String? cityName) async {
    try {
      final result = await remoteDataSource.getCityWeather(cityName);
      return Right(result.toEntityList());
    } catch (error) {
      return Left(ServerError(error.toString()));
    }
  }
}
