import 'package:flutter/material.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const ClimaApp());
}

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E293B),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const ClimaPage(),
    );
  }
}

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  final WeatherService _service = WeatherService();
  final TextEditingController _cityController = TextEditingController();

  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _cityController.text = 'Da Nang';
  }

  Future<void> _fetchWeather() async {
    final String city = _cityController.text.trim();
    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'Vui lòng nhập tên thành phố.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final WeatherData data = await _service.getWeatherByCity(city);
      if (!mounted) return;
      setState(() => _weatherData = data);
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B1220), Color(0xFF1E3A8A)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
                    Icon(Icons.cloud_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'Clima - Thời tiết',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Dữ liệu thời tiết trực tiếp theo thành phố',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.location_city, color: Colors.white70),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _cityController,
                          style: const TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (_) {
                            if (!_isLoading) _fetchWeather();
                          },
                          decoration: const InputDecoration(
                            hintText: 'Nhập thành phố (VD: Da Nang)',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: _isLoading ? null : _fetchWeather,
                          icon: const Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _cityChip('Da Nang'),
                      _cityChip('Ha Noi'),
                      _cityChip('Ho Chi Minh'),
                      _cityChip('Hue'),
                      _cityChip('Nha Trang'),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    child: _buildBodyState(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyState() {
    if (_isLoading) {
      return const Center(
        key: ValueKey('loading'),
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_errorMessage != null) {
      return Center(
        key: const ValueKey('error'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.redAccent),
          ),
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_weatherData == null) {
      return const Center(
        key: ValueKey('empty'),
        child: Text(
          'Nhấn biểu tượng tìm kiếm để xem thời tiết trực tiếp.',
          style: TextStyle(color: Colors.white70, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      key: const ValueKey('weather'),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _weatherData!.city,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Text(_weatherIcon(_weatherData!.weatherCode), style: const TextStyle(fontSize: 72)),
          const SizedBox(height: 8),
          Text(
            '${_weatherData!.temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 68,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _service.weatherDescription(_weatherData!.weatherCode),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, color: Colors.white70, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Cập nhật: ${_formatNow()}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cityChip(String city) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () {
            _cityController.text = city;
            if (!_isLoading) _fetchWeather();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white30),
            ),
            child: Text(
              city,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatNow() {
    final DateTime now = DateTime.now();
    final String hh = now.hour.toString().padLeft(2, '0');
    final String mm = now.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  String _weatherIcon(int code) {
    if (code == 0) return '☀️';
    if ([1, 2, 3].contains(code)) return '⛅';
    if ([45, 48].contains(code)) return '🌫️';
    if ([51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82].contains(code)) {
      return '🌧️';
    }
    if ([71, 73, 75, 77, 85, 86].contains(code)) return '❄️';
    if ([95, 96, 99].contains(code)) return '⛈️';
    return '🌤️';
  }
}
