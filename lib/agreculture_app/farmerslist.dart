import 'package:agre_aproject/agreculture_app/farmerdetails.dart';
import 'package:flutter/material.dart';

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
      home: FarmersList(),
    );
  }
}

class FarmersList extends StatelessWidget {
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
                    'Agriculture Experts',
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
    'assets/images/farmers/farmer-1.jpg',
    'assets/images/farmers/farmer-4.jpg',
    'assets/images/farmers/farmers-5.jpg',
    'assets/images/farmers/farmers-6.jpg',
    'assets/images/farmers/farmers-8.jpeg',
  ];

  final List<String> marketpricetitle = [
    'Malavva',
    'Chanappa',
    'Shankrappa',
    'Madevappa',
    'Rudranna & Family',
  ];

  final List<String> marketpricedescription = [
    'Because of their high fertility and retentivity of moisture, the black soil is widely used for producing several important crops. Some of the major crops grown on the black soils are cotton, wheat, jowar, linseed, castor, sunflower and millets',
    'The lowermost area of red soil is dark in color and very fertile, while the upper layer is sandy and porous. Thus, proper use of fertilizers and irrigation yields high production of cotton, wheat, rice, pulses, millets, tobacco, oil seeds, potatoes, and fruits.',
    'These soils are heterogeneous in nature, with different characteristics depending on the mountainous environment and altitude. (ii) The soils are high in humus but low in potash, phosphorus, and lime. (iii) The soils are particularly suited to the cultivation of tea and coffee, spices and fruits.',
    'Coastal alluvium soils are of marine origin and are seen along the coastal plains and basin lands as a narrow strip. Alluvium soils are formed from fluvial sediments of lacustrine or riverine sediments. Forest soils are seen under forest cover and are formed from crystalline rocks of Archaean age.',
    'Coastal alluvium soils are of marine origin and are seen along the coastal plains and basin lands as a narrow strip. Alluvium soils are formed from fluvial sediments of lacustrine or riverine sediments. Forest soils are seen under forest cover and are formed from crystalline rocks of Archaean age.',
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
                                        builder: (context) => FarmersDetails()),
                                  );
                                  // Add onPressed action for the button
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
                                  'Book a slot',
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
