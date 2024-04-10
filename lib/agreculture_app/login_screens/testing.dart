import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Web Scraping Example'),
        ),
        body: MarketDataPage(),
      ),
    );
  }
}

class MarketDataPage extends StatefulWidget {
  @override
  _MarketDataPageState createState() => _MarketDataPageState();
}

class _MarketDataPageState extends State<MarketDataPage> {
  String marketData = '';

  @override
  void initState() {
    super.initState();
    fetchMarketData();
  }

  Future<void> fetchMarketData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.napanta.com/market-trend/karnataka/haveri/haveri/cotton/gch#google_vignette'));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final body = document.body;
        if (body != null) {
          setState(() {
            marketData = body.text;
          });
        } else {
          print('No body content found in the HTML document.');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          marketData,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
