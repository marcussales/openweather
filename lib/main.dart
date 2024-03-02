import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_poc_flutter/common/config/dependency_injection.dart';
import 'package:weather_poc_flutter/common/utils/base_ds/colors_util.dart';

import 'features/city_weather/presentation/city_weather/screens/city_search_screen.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      await DependencyInjection.init();
      runApp(const WeatherApp());
    },
    (error, stack) => {},
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(background: ColorsUtil.defaultBg),
      ),
      home: const CitySearchScreen(),
    );
  }
}
