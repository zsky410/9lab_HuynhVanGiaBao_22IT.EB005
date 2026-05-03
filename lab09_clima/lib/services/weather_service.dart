import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherData {
  const WeatherData({
    required this.city,
    required this.temperature,
    required this.weatherCode,
  });

  final String city;
  final double temperature;
  final int weatherCode;
}

class WeatherService {
  static const String _geocodingBase =
      'https://geocoding-api.open-meteo.com/v1/search';
  static const String _forecastBase = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherData> getWeatherByCity(String cityName) async {
    final Uri geocodingUri =
        Uri.parse('$_geocodingBase?name=$cityName&count=1&language=vi');
    final http.Response geoResponse = await http.get(geocodingUri);
    if (geoResponse.statusCode != 200) {
      throw Exception('Không thể tìm vị trí thành phố.');
    }

    final dynamic geoJson = jsonDecode(geoResponse.body);
    final List<dynamic>? results = geoJson['results'] as List<dynamic>?;
    if (results == null || results.isEmpty) {
      throw Exception('Không tìm thấy thành phố bạn nhập.');
    }

    final dynamic first = results.first;
    final double latitude = (first['latitude'] as num).toDouble();
    final double longitude = (first['longitude'] as num).toDouble();
    final String city = first['name'] as String;

    final Uri forecastUri = Uri.parse(
      '$_forecastBase?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code',
    );
    final http.Response weatherResponse = await http.get(forecastUri);
    if (weatherResponse.statusCode != 200) {
      throw Exception('Không lấy được dữ liệu thời tiết.');
    }

    final dynamic weatherJson = jsonDecode(weatherResponse.body);
    final dynamic current = weatherJson['current'];
    return WeatherData(
      city: city,
      temperature: (current['temperature_2m'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
    );
  }

  String weatherDescription(int code) {
    if (code == 0) return 'Trời quang';
    if ([1, 2, 3].contains(code)) return 'Có mây';
    if ([45, 48].contains(code)) return 'Sương mù';
    if ([51, 53, 55, 56, 57].contains(code)) return 'Mưa phùn';
    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(code)) return 'Có mưa';
    if ([71, 73, 75, 77, 85, 86].contains(code)) return 'Có tuyết';
    if ([95, 96, 99].contains(code)) return 'Dông';
    return 'Thời tiết chưa xác định';
  }
}
