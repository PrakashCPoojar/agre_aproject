import 'package:flutter/material.dart';
import 'package:agre_aproject/agreculture_app/cropdetailpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF779D07),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomecropsTab(),
    );
  }
}

class HomecropsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Row
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Left section
                    ClipOval(
                      child: Image.asset(
                        'assets/images/login/person-profile-icon.png',
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'User\'s Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(), // Added Spacer widget

                    // Right section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 18),
                        SizedBox(width: 5),
                        Text('Location'),
                      ],
                    ),
                  ],
                ),
              ),

              // Second Row
              WeatherWidget(),

              // Fourth Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Padding(
                  padding:
                      EdgeInsets.all(8.0), // Add padding around the Text widget
                  child: Text(
                    'Crops',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set the text color to green
                    ),
                  ),
                ),
              ),
              VerticalCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.transparent, // Set card color to transparent
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/weather/weather-bg.jpg'), // Background image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Today\'s Weather',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Temperature: 25°C',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        'Humidity: 60%',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        'Wind Speed: 10 km/h',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wb_cloudy,
                      size: 72,
                      color: Colors.grey,
                    ),
                    // SizedBox(height: 20),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        // Add onPressed action for the refresh icon
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 36,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalCard extends StatelessWidget {
  // List of image asset paths
  final List<String> imageAssetPaths = [
    'assets/images/crops/adike.jpg',
    'assets/images/crops/jolla.jpeg',
    'assets/images/crops/batha.jpg',
    'assets/images/crops/kabbu.webp',
    'assets/images/crops/cotton.webp',
  ];

  final List<String> marketpricetitle = [
    'betel nut',
    'Mekke Jolla',
    'Rice',
    'Sugar cane',
    'Cotton',
  ];

  final List<String> marketpricedescription = [
    'The arecanut palm is the source of common chewing nut, popularly known as betel nut or Supari. In India it is extensively used by large sections of people and is very much linked with religious practices. India is the largest producer of arecanut and at the same time largest consumer also. Major states cultivating this crop are Karnataka (40%), Kerala (25%), Assam (20%',
    'Maize (Zea mays L.) is one of the most versatile emerging crop shaving wider adaptability under varied agro-climatic conditions. Globally, maize is known as queen of cereals because it has the highest genetic yield potential among the cereals. It is cultivated on nearly 150 m ha in about 160 countries having wider diversity of soil, climate, biodiversity and management practices that contributes 36 % (782 m t) in the global grain production.',
    'Paddy is cultivated at least twice a year in most parts of India, the two seasons being known as Rabi and Kharif respectively. The former cultivation is dependent on irrigation, while the latter depends on the Monsoon. The paddy cultivation plays a major role in socio-cultural life of rural India.',
    'In general, sugarcane requires 120 to 140 acre inches of water including the rain water. In sandy loam soils, irrigate the channels and then take up planting. In clay soils, plant the setts first and then irrigate. During germination period (30-40 days), irrigate at 10-12 days interval at 5 cm depth.',
    'Cotton is sown using tractor or bullock drawn seed drill or by dibbling. Hand dibbling of seeds at recommended spacing is commonly practiced in rainfed areas particularly for hybrids. This system ensures proper plant stand, uniform geometry and also saves seeds.',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: imageAssetPaths.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 150, // Set the height of the card
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Left side image
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: double.infinity,
                  child: Image.asset(
                    imageAssetPaths[index], // Load image from local assets
                    fit: BoxFit.cover,
                  ),
                ),
                // Middle section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indian Price Tag
                        Row(
                          children: [
                            // Title
                            Text(
                              marketpricetitle[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                          width: double
                              .infinity, // Ensure the text takes the available width
                          child: Text(
                            marketpricedescription[index],
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                            maxLines: 4,
                            textAlign: TextAlign.justify, // Maximum lines
                            overflow: TextOverflow
                                .ellipsis, // Ellipsis when exceeding max lines
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 22, // Specify the height of the button
                              width: 80, // Specify the width of the button
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CropsPage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 0,
                                  ), // Adjust vertical padding to make the button smaller
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                  ), // Adjust font size to make the text smaller
                                ),
                                child: Text(
                                  'Read More',
                                  style: TextStyle(
                                    fontSize:
                                        12.0, // Adjust font size to match the button
                                    // fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // Set the text color to black
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
