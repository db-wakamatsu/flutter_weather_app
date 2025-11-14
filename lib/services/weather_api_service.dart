import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  WeatherApiService({Dio? dio}) : _dio = dio ?? Dio();

  String get _apiKey => dotenv.env['OPENWEATHER_API_KEY'] ?? '';

  /// 現在の天気を取得
  Future<Map<String, dynamic>> getCurrentWeather(String cityName) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric', // 摂氏温度
          'lang': 'ja', // 日本語
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 7日間の天気予報を取得
  Future<Map<String, dynamic>> getForecast(String cityName) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric',
          'lang': 'ja',
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '接続がタイムアウトしました';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return '都市が見つかりませんでした';
        } else if (statusCode == 401) {
          return 'APIキーが無効です';
        }
        return 'サーバーエラーが発生しました';
      case DioExceptionType.cancel:
        return 'リクエストがキャンセルされました';
      case DioExceptionType.unknown:
        return 'ネットワークエラーが発生しました';
      default:
        return '予期しないエラーが発生しました';
    }
  }
}
