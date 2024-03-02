import 'package:bloc/bloc.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/entities/city_weather.dart';
import 'package:weather_poc_flutter/features/city_weather/domain/use_cases/get_city_weather_use_case.dart';

part 'city_weather_event.dart';
part 'city_weather_state.dart';

class CityWeatherDetailBloc extends Bloc<CityWeatherDetailEvent, CityWeatherDetailState> {
  final GetCityWeatherUseCase getCityWeatherUseCase;

  CityWeatherDetailBloc(this.getCityWeatherUseCase) : super(const CityWeatherDetailState()) {
    on<GetCityWeatherDetailEvent>(_onGetCityDetail);
  }

  void _onGetCityDetail(GetCityWeatherDetailEvent event, Emitter<CityWeatherDetailState> emit) async {
    emit(state.copyWith(status: CityWeatherDetailStateStatus.loading));
    final result = await getCityWeatherUseCase.getCityWeather(event.cityName);
    result.fold(
      (failure) => emit(state.copyWith(weatherForecast: [], status: CityWeatherDetailStateStatus.idle)),
      (success) => emit(state.copyWith(weatherForecast: success, status: CityWeatherDetailStateStatus.idle)),
    );
    
  }
}
