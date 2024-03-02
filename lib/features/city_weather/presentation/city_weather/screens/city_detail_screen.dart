import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_poc_flutter/common/config/dependency_injection.dart';
import 'package:weather_poc_flutter/common/utils/base_ds/colors_util.dart';
import 'package:weather_poc_flutter/common/utils/base_ds/sizes.dart';
import 'package:weather_poc_flutter/common/utils/cities_enum.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/entities/city_weather.dart';

import '../bloc/city_weather_bloc.dart';

class CityDetailScreen extends StatefulWidget {
  final String city;
  const CityDetailScreen({super.key, required this.city});

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  final _bloc = getIt.get<CityWeatherDetailBloc>();

  @override
  void initState() {
    _getCityWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset(_currentCityIcon, height: 22, width: 22),
            const SizedBox(width: 16),
            Text(_currentCityName, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        titleSpacing: 0.0,
        centerTitle: false,
        backgroundColor: ColorsUtil.clearGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CityWeatherDetailBloc, CityWeatherDetailState>(
            bloc: _bloc,
            builder: (context, state) {
              return state.status == CityWeatherDetailStateStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : state.weatherForecast == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              const Text(
                                'Ops, destino não encontrado',
                                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                'assets/images/gps.png',
                                height: 350,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            _header(state.weatherForecast?.first),
                            Expanded(
                              child: Stack(
                                children: [
                                  FractionalTranslation(
                                    translation: const Offset(0.0, 0.0),
                                    child: Image.asset(
                                      'assets/images/cities.png',
                                      height: 350,
                                      width: double.infinity,
                                    ),
                                  ),
                                  _footer(state.weatherForecast ?? []),
                                ],
                              ),
                            ),
                          ],
                        );
            }),
      ),
    );
  }

  Container _header(CityWeather? weather) {
    return Container(
      height: Sizes.headerHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsUtil.clearGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 16.0, bottom: 8.0),
            child: Row(
              children: [
                weather?.iconCode != null ? Image.network(weather?.iconCode ?? '') : const SizedBox.shrink(),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather?.averageTemperature} °C',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      '${weather?.weatherDescription}',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Positioned _footer(List<CityWeather> list) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: Sizes.footerHeight,
        decoration: const BoxDecoration(
          color: ColorsUtil.clearGreen,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Próximos dias", style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: list
                    .map(
                      (weather) => Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: ColorsUtil.darkGreen,
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Máx.',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      '${weather.temperatureMax} °C',
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Image.network(weather.iconCode ?? ''),
                                    ),
                                    const Text(
                                      'Min.',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      '${weather.temperatureMin} °C',
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCityWeather() {
    _bloc.add(GetCityWeatherDetailEvent(_currentCityName));
  }

  String get _currentCityName => widget.city;
  String get _currentCityIcon => CityDataHelper.iconByDescription(_currentCityName);
}
