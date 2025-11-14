import '../models/weather.dart';
import '../services/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiService _apiService;

  WeatherRepository({WeatherApiService? apiService})
      : _apiService = apiService ?? WeatherApiService();

  /// 現在の天気を取得
  Future<Weather> getCurrentWeather(String cityName) async {
    final data = await _apiService.getCurrentWeather(cityName);
    return _parseCurrentWeather(data);
  }

  /// 7日間の天気予報を取得
  Future<WeatherForecast> getForecast(String cityName) async {
    final data = await _apiService.getForecast(cityName);
    return _parseForecast(data);
  }

  /// 現在の天気データをパース
  Weather _parseCurrentWeather(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weather =
        (json['weather'] as List<dynamic>)[0] as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>;

    return Weather(
      cityName: json['name'] as String,
      temperature: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      humidity: main['humidity'] as int,
      windSpeed: (wind['speed'] as num).toDouble(),
      description: weather['description'] as String,
      icon: weather['icon'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] as int) * 1000,
      ),
    );
  }

  /// 予報データをパース
  WeatherForecast _parseForecast(Map<String, dynamic> json) {
    final city = json['city'] as Map<String, dynamic>;
    final list = json['list'] as List<dynamic>;

    // 1日ごとにグループ化（3時間ごとのデータを1日分に集約）
    final Map<String, List<Map<String, dynamic>>> dailyData = {};

    for (var item in list) {
      final dt = DateTime.fromMillisecondsSinceEpoch(
        (item['dt'] as int) * 1000,
      );
      final dateKey = '${dt.year}-${dt.month}-${dt.day}';

      if (!dailyData.containsKey(dateKey)) {
        dailyData[dateKey] = [];
      }
      dailyData[dateKey]!.add(item as Map<String, dynamic>);
    }

    // 最大7日分の予報を作成
    final dailyForecasts = <DailyForecast>[];
    final sortedDates = dailyData.keys.toList()..sort();

    for (var i = 0; i < sortedDates.length && i < 7; i++) {
      final dateKey = sortedDates[i];
      final dayData = dailyData[dateKey]!;

      // その日の最高気温・最低気温を計算
      double tempMax = double.negativeInfinity;
      double tempMin = double.infinity;
      String description = '';
      String icon = '';

      for (var item in dayData) {
        final main = item['main'] as Map<String, dynamic>;
        final temp = (main['temp'] as num).toDouble();

        if (temp > tempMax) {
          tempMax = temp;
        }
        if (temp < tempMin) {
          tempMin = temp;
        }

        // 正午のデータを代表として使用
        final dt = DateTime.fromMillisecondsSinceEpoch(
          (item['dt'] as int) * 1000,
        );
        if (dt.hour == 12 || description.isEmpty) {
          final weather =
              (item['weather'] as List<dynamic>)[0] as Map<String, dynamic>;
          description = weather['description'] as String;
          icon = weather['icon'] as String;
        }
      }

      final date = DateTime.parse(dateKey);
      dailyForecasts.add(
        DailyForecast(
          date: date,
          tempMax: tempMax,
          tempMin: tempMin,
          description: description,
          icon: icon,
        ),
      );
    }

    return WeatherForecast(
      cityName: city['name'] as String,
      dailyForecasts: dailyForecasts,
    );
  }
}
