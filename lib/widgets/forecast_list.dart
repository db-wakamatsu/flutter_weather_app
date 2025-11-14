import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';
import '../utils/weather_icon_helper.dart';

class ForecastList extends StatelessWidget {
  final WeatherForecast forecast;

  const ForecastList({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '7日間の天気予報',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...forecast.dailyForecasts.map((daily) {
              return _ForecastItem(forecast: daily);
            }),
          ],
        ),
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final DailyForecast forecast;

  const _ForecastItem({required this.forecast});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('M/d (E)', 'ja_JP');
    final dateStr = dateFormat.format(forecast.date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              dateStr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 8),
          WeatherIconHelper.getWeatherIcon(
            forecast.icon,
            forecast.description,
            size: 50,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              forecast.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${forecast.tempMax.toStringAsFixed(0)}° / ${forecast.tempMin.toStringAsFixed(0)}°',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
