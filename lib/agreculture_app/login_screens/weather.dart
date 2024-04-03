import 'package:agre_aproject/agreculture_app/login_screens/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _currentWeather;
  List<Weather>? _forecast;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    _currentWeather = await _wf.currentWeatherByCityName("Bengaluru");
    _forecast = await _wf.fiveDayForecastByCityName("Bengaluru");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Information',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF779D07),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color.fromARGB(255, 209, 224, 250),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentWeather == null || _forecast == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _locationHeader(),
          SizedBox(height: 16),
          _currentWeatherInfo(),
          SizedBox(height: 16),
          Text(
            'Next 5 Days Forecast:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF120142),
            ),
          ),
          SizedBox(height: 8),
          _forecastInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _currentWeather?.areaName ?? "",
      style: TextStyle(
        fontSize: 24,
        // fontWeight: FontWeight.bold,
        color: Color(0xFF120142),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _currentWeatherInfo() {
    DateTime now = _currentWeather!.date!;
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "  ${DateFormat("MMM d, ").format(now)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: Color(0xFF779D07),
              ),
            ),
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF120142),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          width: 250, // Adjust the width as needed
          height: 250, // Adjust the height as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 58, 88, 224), // Circle background color
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/weather/weather-bg.jpg'), // Replace 'assets/background_image.jpg' with your image asset path
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _weatherIcon(),
              SizedBox(height: 8),
              _currentTemp(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          "http://openweathermap.org/img/wn/${_currentWeather?.weatherIcon}@2x.png",
          width: 100,
          height: 100,
        ),
        Text(
          _currentWeather?.weatherDescription ?? "",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF120142),
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_currentWeather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color(0xFF120142),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _forecastInfo() {
    // Filter out duplicate days
    List<Weather> uniqueForecasts = [];
    for (var forecast in _forecast!) {
      if (!uniqueForecasts
          .any((element) => element.date?.day == forecast.date?.day)) {
        uniqueForecasts.add(forecast);
      }
    }

    return Container(
      height: 150, // Adjust the height as needed
      // color: Color(0xFFECF3FE), // Background color
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: uniqueForecasts.length,
        itemBuilder: (context, index) {
          Weather forecast = uniqueForecasts[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 3,
              color: Colors.white, // Card background color
              child: Container(
                width: 100, // Adjust the width of each card as needed
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat("EEEE").format(forecast.date!),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF120142),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${forecast.temperature?.celsius?.toStringAsFixed(0)}° C",
                      style: TextStyle(
                        color: Color(0xFF120142),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      forecast.weatherDescription ?? "",
                      style: TextStyle(
                        color: Color(0xFF120142),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
