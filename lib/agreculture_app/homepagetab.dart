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
      home: HomePageTab(),
    );
  }
}

class HomePageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Row
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showUserProfileDialog(context);
                      },
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/login/person-profile-icon.png',
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
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

              // Third Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Padding(
                  padding:
                      EdgeInsets.all(8.0), // Add padding around the Text widget
                  child: Text(
                    'Blog',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set the text color to green
                    ),
                  ),
                ),
              ),
              HorizontalScrollCard(),

              // Fourth Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Padding(
                  padding:
                      EdgeInsets.all(8.0), // Add padding around the Text widget
                  child: Text(
                    'Market price',
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

  void _showUserProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Profile'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/login/person-profile-icon.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              // ClipOval(),
              SizedBox(height: 10),
              Text(
                'Full Name: Users Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Contact Number: +1234567890',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Address: Your Address Here',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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

class HorizontalScrollCard extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/crops/batha.jpg',
    'assets/images/crops/kabbu.webp',
    'assets/images/crops/jolla.jpeg',
    'assets/images/crops/bath-1.jpg',
    'assets/images/crops/adike.jpg',
  ];

  final List<String> blogtitles = [
    'Rice',
    'Sugar cane',
    'Corn',
    'Rice 1001',
    'Betel nut',
  ];

  final List<String> blogdescriptions = [
    'Rice is one of the chief grains of India. Moreover, this country has the largest area under rice cultivation. As it is one of the principal food crops. It is, in fact, the dominant crop of the country. India is one of the leading producers of this crop. Rice is the basic food crop and being a tropical plant, it flourishes comfortably in a hot and humid climate.',
    'Sugarcane thrives in hot, sunny tropical regions with ample rainfall or irrigation, needing a long, warm growing season and high solar radiation.',
    'Corn plants have specific soil requirements. Early varieties grow best in sand or loam, while late varieties grow best in silty or clayey types of soil.',
    'Rice is one of the chief grains of India. Moreover, this country has the largest area under rice cultivation. As it is one of the principal food crops. It is, in fact, the dominant crop of the country. India is one of the leading producers of this crop. Rice is the basic food crop and being a tropical plant, it flourishes comfortably in a hot and humid climate.',
    'Seedlings of 1 to 2 years of age should be planted in pits of about 90 x 90 x 90 cm at a spacing of 2.75 to 3.0 meter either way and covered with soil to the collar level of the plants and press the soil around. It is essential to provide shade during summer months.',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 170,
                margin: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 200,
                      child: Image.asset(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        blogtitles[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 60, // Adjust the height as needed
                        child: Text(
                          blogdescriptions[index],
                          style: TextStyle(fontSize: 14),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      width: double
                          .infinity, // Set width to 100% of the available space
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CropsPage()),
                          );
                          // Add onPressed action for the button
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical:
                                  2), // Adjust vertical padding to make the button smaller
                          textStyle: TextStyle(
                              fontSize:
                                  12), // Adjust font size to make the text smaller
                        ),
                        child: Text(
                          'Read More',
                          style: TextStyle(
                            fontSize:
                                12.0, // Adjust font size to match the button
                            // fontWeight: FontWeight.bold,
                            color: Colors.white, // Set the text color to black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class VerticalCard extends StatelessWidget {
  // List of image asset paths
  final List<String> imageAssetPaths = [
    'assets/images/crops/batha.jpg',
    'assets/images/crops/kabbu.webp',
    'assets/images/crops/jolla.jpeg',
    'assets/images/crops/bath-1.jpg',
    'assets/images/crops/adike.jpg',
  ];

  final List<String> marketpricetitle = [
    'Batha',
    'Kabhu',
    'Jolla',
    'Batha 1001',
    'Adike',
  ];

  final List<double> marketPrices = [
    24000.00,
    35000.00,
    42000.00,
    29000.00,
    38000.00,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: imageAssetPaths.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100, // Set the height of the card
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
                            Spacer(), // Spacer to fill the available space
                            Text(
                              '₹', // Indian Rupee symbol
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ${marketPrices[index]}', // Price value
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10), // Add vertical padding
                          child: Row(
                            children: [
                              Spacer(), // Spacer to fill the available space
                              Icon(
                                Icons.arrow_upward,
                                color: Colors
                                    .green[900], // Set color based on condition
                              ),
                              SizedBox(
                                  width:
                                      8), // Add some space between the icon and text
                              Text(
                                '8.4 %', // Text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                            ],
                          ),
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
