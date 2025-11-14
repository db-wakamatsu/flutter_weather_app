import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather.dart';
import '../repositories/weather_repository.dart';

// Repository Provider
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

// 現在の天気を取得するProvider
final currentWeatherProvider =
    FutureProvider.family<Weather, String>((ref, cityName) async {
  final repository = ref.watch(weatherRepositoryProvider);
  return repository.getCurrentWeather(cityName);
});

// 天気予報を取得するProvider
final weatherForecastProvider =
    FutureProvider.family<WeatherForecast, String>((ref, cityName) async {
  final repository = ref.watch(weatherRepositoryProvider);
  return repository.getForecast(cityName);
});

// 都市名を管理するStateProvider
final cityNameProvider = StateProvider<String>((ref) => 'Tokyo');
