import 'package:flutter/material.dart';
import 'package:agre_aproject/agreculture_app/dealersdetails.dart';

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
      home: HometoolTab(),
    );
  }
}

class HometoolTab extends StatelessWidget {
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
                    'Buy tools',
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
    'assets/images/tools/tractor.webp',
    'assets/images/tools/tactor-equipments.jpg',
    'assets/images/tools/farming-and-gardening-tools-equipment.jpg',
    'assets/images/tools/cultivator.jpg',
    'assets/images/tools/hydraulic-tractor-trailer.jpg',
  ];

  final List<String> marketpricetitle = [
    'John Deere Tractors',
    'Tractor supporting tools',
    'farming and gardening tools',
    'cultivator',
    'Hydraulic-tractor-trailer',
  ];

  final List<String> marketpricedescription = [
    'A tractor is an engineering vehicle specifically designed to deliver a high tractive effort at slow speeds, for the purposes of hauling a trailer or machinery such as that used in agriculture, mining or construction',
    'Benefits Of Modern Agriculture Machinery The use of farm equipment reduces manual labor',
    'The following maintenance practices or precautions are to be adopted to prolong the life span and effective use of farm tools',
    'A cultivator, which is a tractor driven agricultural implement, is used for loosening and turning the soil. Using a cultivator saves labour and time. It has multiple ploughs attached to a single frame that is driven by a tractor in order to complete ploughing in a short period of time',
    'Tractor trolleys are generally used for carrying and storing agricultural items from one place to the other. It is also used for tilling the soil where crops need to be planted.',
  ];

  final List<String> marketprice = [
    '10,52,000',
    ' Start 22,000',
    '9,000',
    '19,000',
    '1,85,000',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: imageAssetPaths.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 120, // Set the height of the card
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Left side image
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                      imageAssetPaths[index], // Load image from local assets
                      fit: BoxFit.cover,
                    ),
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
                            maxLines: 2,
                            textAlign: TextAlign.justify, // Maximum lines
                            overflow: TextOverflow
                                .ellipsis, // Ellipsis when exceeding max lines
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10), // Add top margin
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Align items vertically centered
                            children: [
                              Text(
                                '₹ ' + marketprice[index] + '.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 22, // Specify the height of the button
                                width: 100, // Specify the width of the button
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DealerPage()),
                                    );
                                    // Add onPressed action for the button
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ), // Adjust vertical padding to make the button smaller
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                    ), // Adjust font size to make the text smaller
                                  ),
                                  child: Text(
                                    'Contact Dealer',
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
