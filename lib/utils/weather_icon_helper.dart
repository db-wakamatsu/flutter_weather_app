import 'package:flutter/material.dart';

class WeatherIconHelper {
  static Widget getWeatherIcon(String iconCode, String description, {double size = 120}) {
    final iconData = _getIconData(iconCode, description);
    final color = _getIconColor(iconCode, description);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.3),
            color.withOpacity(0.1),
          ],
        ),
      ),
      child: Icon(
        iconData,
        size: size * 0.7,
        color: color,
      ),
    );
  }

  static IconData _getIconData(String iconCode, String description) {
    final lowerDesc = description.toLowerCase();
    final code = iconCode.toLowerCase();

    // 晴れ
    if (code.contains('01') || lowerDesc.contains('clear') || lowerDesc.contains('晴')) {
      return Icons.wb_sunny;
    }
    // 少し曇り
    else if (code.contains('02') || lowerDesc.contains('few clouds')) {
      return Icons.wb_cloudy;
    }
    // 曇り
    else if (code.contains('03') || code.contains('04') ||
             lowerDesc.contains('cloud') || lowerDesc.contains('曇')) {
      return Icons.cloud;
    }
    // 雨
    else if (lowerDesc.contains('rain') || lowerDesc.contains('雨') ||
             lowerDesc.contains('drizzle')) {
      if (lowerDesc.contains('light')) {
        return Icons.grain; // 小雨
      }
      return Icons.umbrella; // 雨
    }
    // 雷雨
    else if (lowerDesc.contains('thunder') || lowerDesc.contains('雷')) {
      return Icons.flash_on;
    }
    // 雪
    else if (lowerDesc.contains('snow') || lowerDesc.contains('雪')) {
      return Icons.ac_unit;
    }
    // 霧
    else if (lowerDesc.contains('mist') || lowerDesc.contains('fog') ||
             lowerDesc.contains('霧')) {
      return Icons.blur_on;
    }
    // その他
    else {
      return Icons.wb_cloudy;
    }
  }

  static Color _getIconColor(String iconCode, String description) {
    final lowerDesc = description.toLowerCase();
    final code = iconCode.toLowerCase();

    // 晴れ
    if (code.contains('01') || lowerDesc.contains('clear') || lowerDesc.contains('晴')) {
      return Colors.orange.shade600;
    }
    // 少し曇り
    else if (code.contains('02') || lowerDesc.contains('few clouds')) {
      return Colors.amber.shade700;
    }
    // 曇り
    else if (code.contains('03') || code.contains('04') ||
             lowerDesc.contains('cloud') || lowerDesc.contains('曇')) {
      return Colors.blueGrey.shade400;
    }
    // 雨
    else if (lowerDesc.contains('rain') || lowerDesc.contains('雨') ||
             lowerDesc.contains('drizzle')) {
      return Colors.blue.shade600;
    }
    // 雷雨
    else if (lowerDesc.contains('thunder') || lowerDesc.contains('雷')) {
      return Colors.deepPurple.shade400;
    }
    // 雪
    else if (lowerDesc.contains('snow') || lowerDesc.contains('雪')) {
      return Colors.lightBlue.shade200;
    }
    // 霧
    else if (lowerDesc.contains('mist') || lowerDesc.contains('fog') ||
             lowerDesc.contains('霧')) {
      return Colors.grey.shade400;
    }
    // その他
    else {
      return Colors.blue.shade400;
    }
  }
}
