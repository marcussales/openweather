import 'package:get_it/get_it.dart';
import 'package:weather_poc_flutter/features/city_weather/data/data_sources/city_weather_remote_data_source.dart';
import 'package:weather_poc_flutter/features/city_weather/data/repositories/city_weather_repository_impl.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/repositories/city_weather_repository.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/use_cases/get_city_weather_use_case.dart';

import '../presentation/city_weather/bloc/city_weather_bloc.dart';

mixin CityWeatherInjection {
  static Future<void> inject(GetIt getIt) async {
    getIt.registerLazySingleton<CityWeatherDetailBloc>(() => CityWeatherDetailBloc(getIt()));
    getIt.registerLazySingleton<CityWeatherRepository>(() => CityWeatherRepositoryImpl(getIt()));
    getIt.registerLazySingleton<CityWeatherRemoteDataSource>(() => CityWeatherRemoteDataSourceImpl(getIt()));
    getIt.registerLazySingleton<GetCityWeatherUseCase>(() => GetCityWeatherUseCaseImpl(getIt()));
  }
}
