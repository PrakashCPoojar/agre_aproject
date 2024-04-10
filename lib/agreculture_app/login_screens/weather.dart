import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Weather Information',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF2F4F66),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError || snapshot.data == null) {
              return Center(child: Text('Error: Failed to load weather data'));
            } else {
              Weather? currentWeather = snapshot.data![0] as Weather?;
              List<Weather>? forecast = snapshot.data![1] as List<Weather>?;
              return _buildWeatherUI(context, currentWeather, forecast);
            }
          }
        },
      ),
    );
  }

  Future<List<dynamic>> _fetchWeatherData() async {
    final WeatherFactory wf =
        WeatherFactory("81bc43e3e7c43c44ab37010db3794515");
    Weather currentWeather = await wf.currentWeatherByCityName("Bengaluru");
    List<Weather> forecast = await wf.fiveDayForecastByCityName("Bengaluru");
    return [currentWeather, forecast];
  }

  Widget _buildWeatherUI(
      BuildContext context, Weather? currentWeather, List<Weather>? forecast) {
    if (currentWeather == null || forecast == null) {
      return Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _currentWeatherHeader(currentWeather),
          _currentWeatherDetails(currentWeather),
          _forecastHeader(),
          _forecastList(forecast),
        ],
      ),
    );
  }

  Widget _currentWeatherHeader(Weather currentWeather) {
    return Container(
      color: Color(0xFF2F4F66),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            currentWeather.areaName ?? "",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            DateFormat("EEEE, MMM d").format(currentWeather.date!),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            currentWeather.weatherDescription ?? "",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Image.network(
            "http://openweathermap.org/img/wn/${currentWeather.weatherIcon}@2x.png",
            width: 100,
            height: 100,
          ),
          SizedBox(height: 8),
          Text(
            "${currentWeather.temperature?.celsius?.toStringAsFixed(0)}° C",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _currentWeatherDetails(Weather currentWeather) {
    return Container(
      color: Color(0xFFE4E6EB),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _detailItem("Humidity", "${currentWeather.humidity}%"),
          _detailItem("Wind Speed", "${currentWeather.windSpeed} km/h"),
          _detailItem("Pressure", "${currentWeather.pressure} hPa"),
        ],
      ),
    );
  }

  Widget _detailItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _forecastHeader() {
    return Container(
      color: Color(0xFF2F4F66),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(
        "Next 5 Days Forecast",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _forecastList(List<Weather> forecast) {
    // Group forecast by day
    Map<DateTime, List<Weather>> groupedForecast = {};
    forecast.forEach((item) {
      DateTime date = item.date!;
      DateTime day = DateTime(date.year, date.month, date.day);
      if (!groupedForecast.containsKey(day)) {
        groupedForecast[day] = [];
      }
      groupedForecast[day]!.add(item);
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: groupedForecast.entries.map((entry) {
          DateTime day = entry.key;
          List<Weather> forecasts = entry.value;
          Weather firstForecast = forecasts.first;

          return Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  Color(0xFF2F4F66), // Set your desired background color here
              borderRadius:
                  BorderRadius.circular(12), // Optional: Add border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("EEEE, MMM d").format(day),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Image.network(
                        "http://openweathermap.org/img/wn/${firstForecast.weatherIcon}@2x.png",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firstForecast.weatherDescription ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white), // Set text color to white
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${firstForecast.temperature?.celsius?.toStringAsFixed(0)}° C",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white), // Set text color to white
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (forecasts.length > 1)
                    Text(
                      "and ${forecasts.length - 1} more...",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white), // Set text color to white
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
