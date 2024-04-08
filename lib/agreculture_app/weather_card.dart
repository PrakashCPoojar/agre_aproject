import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

const OPENWEATHER_API_KEY = '81bc43e3e7c43c44ab37010db3794515';

class WeatherAppCard extends StatefulWidget {
  const WeatherAppCard({Key? key}) : super(key: key);

  @override
  State<WeatherAppCard> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherAppCard> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _currentWeather;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    _currentWeather = await _wf.currentWeatherByCityName("Bengaluru");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_currentWeather == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          _currentWeatherInfo(),
        ],
      ),
    );
  }

  Widget _currentWeatherInfo() {
    DateTime now = _currentWeather!.date!;
    return Container(
      width: 500,
      height: 250,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 58, 88, 224),
        image: DecorationImage(
          image: AssetImage(
              'assets/images/weather/weather-bg.jpg'), // Replace with your image path
          fit: BoxFit.cover, // Adjust the fit as needed
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _currentWeather?.areaName ?? "",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF120142),
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.network(
                  "http://openweathermap.org/img/wn/${_currentWeather?.weatherIcon}@2x.png",
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 8),
                Text(
                  _currentWeather?.weatherDescription ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF120142),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            color:
                Colors.black, // Change the color of the divider line as needed
            height: 200, // Adjust the height of the divider line as needed
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${DateFormat("MMM d, ").format(now)} ${DateFormat("EEEE").format(now)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "${_currentWeather?.temperature?.celsius?.toStringAsFixed(0)}° C",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF120142),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
