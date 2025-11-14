import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/forecast_list.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityName = ref.watch(cityNameProvider);
    final currentWeather = ref.watch(currentWeatherProvider(cityName));
    final forecast = ref.watch(weatherForecastProvider(cityName));

    return Scaffold(
      appBar: AppBar(
        title: const Text('天気予報'),
        backgroundColor: _getBackgroundColor(currentWeather),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _getGradientColors(currentWeather),
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(currentWeatherProvider(cityName));
            ref.invalidate(weatherForecastProvider(cityName));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WeatherSearchBar(
                    onSearch: (city) {
                      ref.read(cityNameProvider.notifier).state = city;
                    },
                  ),
                  const SizedBox(height: 20),
                  currentWeather.when(
                    data: (weather) => CurrentWeatherCard(weather: weather),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          error.toString(),
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  forecast.when(
                    data: (forecastData) =>
                        ForecastList(forecast: forecastData),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          error.toString(),
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(AsyncValue currentWeather) {
    return currentWeather.maybeWhen(
      data: (weather) {
        final description = weather.description.toLowerCase();
        if (description.contains('晴') || description.contains('clear')) {
          return Colors.blue.shade700;
        } else if (description.contains('雨') || description.contains('rain')) {
          return Colors.grey.shade700;
        } else if (description.contains('曇') || description.contains('cloud')) {
          return Colors.blueGrey.shade600;
        } else if (description.contains('雪') || description.contains('snow')) {
          return Colors.cyan.shade300;
        }
        return Colors.blue.shade700;
      },
      orElse: () => Colors.blue.shade700,
    );
  }

  List<Color> _getGradientColors(AsyncValue currentWeather) {
    return currentWeather.maybeWhen(
      data: (weather) {
        final description = weather.description.toLowerCase();
        if (description.contains('晴') || description.contains('clear')) {
          return [Colors.blue.shade700, Colors.blue.shade400];
        } else if (description.contains('雨') || description.contains('rain')) {
          return [Colors.grey.shade700, Colors.grey.shade500];
        } else if (description.contains('曇') || description.contains('cloud')) {
          return [Colors.blueGrey.shade600, Colors.blueGrey.shade400];
        } else if (description.contains('雪') || description.contains('snow')) {
          return [Colors.cyan.shade300, Colors.cyan.shade100];
        }
        return [Colors.blue.shade700, Colors.blue.shade400];
      },
      orElse: () => [Colors.blue.shade700, Colors.blue.shade400],
    );
  }
}
