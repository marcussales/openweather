import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_poc_flutter/common/config/app_http_client.dart';
import 'package:weather_poc_flutter/features/city_weather/shared/city_weather_injection.dart';

final getIt = GetIt.instance;

mixin DependencyInjection {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    getIt.registerLazySingleton<AppHttpService>(() => AppHttpService());

    Future.wait([CityWeatherInjection.inject(getIt)]);
  }
}
