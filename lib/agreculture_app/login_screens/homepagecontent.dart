import 'dart:io';

import 'package:agre_aproject/agreculture_app/farmerslist.dart';
// import 'package:agre_aproject/agreculture_app/login_screens/testing.dart';
import 'package:agre_aproject/agreculture_app/login_screens/weather.dart';
import 'package:agre_aproject/agreculture_app/login_screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weather/weather.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF779D07),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageTab(),
    );
  }
}

class HomePageTab extends StatelessWidget {
  final User = FirebaseAuth.instance.currentUser;

  void signout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // Navigate to the Wrapper page after sign-out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );
    } catch (e) {
      print('Failed to sign out: $e');
      // Handle sign-out failure here, if needed
    }
  }

  String? getFirstName() {
    // Get the current user from FirebaseAuth
    var user = FirebaseAuth.instance.currentUser;

    // Check if the user is signed in and if their display name is not null
    if (user != null && user.displayName != null) {
      // Split the display name by spaces and return the first part
      return user.displayName!.split(' ')[0];
    }

    // If the user is not signed in or their display name is null, return null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Background color for the entire page
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Row
              SizedBox(height: 50, child: Container(color: Color(0xFF779D07))),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    FutureBuilder(
                      future: _getImageUrl(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return GestureDetector(
                          onTap: () {
                            _showUserProfileDialog(context);
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  25), // half of the desired width/height
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: snapshot.hasData
                                    ? NetworkImage(snapshot.data!)
                                    : AssetImage(
                                            'assets/images/login/person-profile-icon.png')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${getFirstName()}',
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
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: Color(0xFF779D07),
                        ),
                        // SizedBox(width: 5),
                        // Text('Location'),
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
              // Container(
              //   margin:
              //       EdgeInsets.only(left: 8), // Adjust left margin for spacing
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => UserProfileDialog()),
              //       );
              //     },
              //     child: const Text(
              //       "Testing",
              //       style: TextStyle(color: Color(0xFF779D07)),
              //     ),
              //   ),
              // ),

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
        return FutureBuilder(
          future: _getImageUrl(), // Fetch the image URL from Firebase Storage
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return AlertDialog(
              title: Text('Your Profile'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        // Display the uploaded profile image or default image
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: snapshot.hasData
                              ? NetworkImage(snapshot.data!)
                              : AssetImage(
                                      'assets/images/login/person-profile-icon.png')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _uploadImage(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 30,
                                color: Color(0xFF779D07),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Full Name: ${FirebaseAuth.instance.currentUser!.displayName}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Email: ${FirebaseAuth.instance.currentUser!.email}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color(0xFF779D07),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Color(0xFF779D07),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

// Function to get the image URL from Firebase Storage
  Future<String> _getImageUrl() async {
    String imageUrl = ''; // Default empty URL

    // Fetch the image URL from Firebase Storage based on user's UID
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images/${FirebaseAuth.instance.currentUser!.uid}');
    imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }

  void _uploadImage(BuildContext context) async {
    final _picker = ImagePicker();
    XFile? image;

    // Pick an image from gallery
    image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Upload image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${FirebaseAuth.instance.currentUser!.uid}');
      UploadTask uploadTask = storageReference.putFile(File(image.path));

      // Get download URL
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();

        // Update user profile image URL in Firestore or Realtime Database
        // Example:
        // await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        //   'profileImageUrl': imageUrl,
        // });
        // or
        // await FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser!.uid}/profileImageUrl').set(imageUrl);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image uploaded successfully.'),
        ));
      }).catchError((error) {
        // Handle upload errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload image: $error'),
        ));
      });
    }
  }
}

class WeatherWidget extends StatelessWidget {
  Future<List<Weather>> _fetchWeatherData() async {
    WeatherFactory wf = WeatherFactory("81bc43e3e7c43c44ab37010db3794515");
    List<Weather> forecasts = await wf.fiveDayForecastByCityName("Bengaluru");
    return forecasts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
      future: _fetchWeatherData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Weather> forecasts = snapshot.data!;
          final Weather currentWeather = forecasts[0];

          return GestureDetector(
            onTap: () {
              // Navigate to another page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherApp()),
              );
            },
            child: Container(
              height: 180,
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(8),
                color: Colors.transparent, // Set card color to transparent
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/weather/weather-bg.png'), // Background image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentWeather.weatherDescription ?? "",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              // SizedBox(height: 0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Image.network(
                                      "http://openweathermap.org/img/wn/${currentWeather.weatherIcon}@2x.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${currentWeather.areaName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${currentWeather.temperature?.celsius?.toStringAsFixed(0)}° C',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromRGBO(56, 234, 255, 100),
                                ),
                              ),
                              Text(
                                'Humidity: ${currentWeather.humidity}%',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Wind Speed: ${currentWeather.windSpeed} km/h',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
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
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // Disable scrolling
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
                                  color: Colors.green[
                                      900], // Set color based on condition
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
      ),
    );
  }
}

class HorizontalScrollCard extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/crops/batha.jpg',
    'assets/images/crops/roses.jpg',
    'assets/images/crops/dairy-farming.jpg',
    'assets/images/crops/VegetableFarming.webp',
    'assets/images/crops/Plantation-Agricultu.jpg',
    'assets/images/crops/mushroom-far.jpg',
    'assets/images/crops/kabbu.webp',
  ];

  final List<String> blogtitles = [
    'Rice',
    'Rose Farming',
    'Dairy',
    'Vegetable Farming',
    'Betel nut',
    'Small Organic crops',
    'Sugar cane'
  ];
  final List<String> relatedVideos = [
    'Pkoov2xIgOA',
    'SolFUJe-BlI',
    'm_3r9RJxIhg',
    'QBXL88qvJkw',
    'lv-8fN5gVr4',
    'q5V5eS1LtfI',
    'wdvrzWtkHfA',
  ];

  final List<String> blogdescriptions = [
    'Rice crop cultivation is a meticulous process that involves several stages from preparation to harvest. It begins with land preparation, including plowing, leveling, and puddling to create a favorable environment for rice seedlings to establish their roots. Farmers then select high-quality rice seeds based on factors such as variety, yield potential, and adaptability to local conditions, often treating them with fungicides or insecticides to protect against pests and diseases. Rice can be sown using either direct seeding or transplanting methods, with water management playing a crucial role due to the crops high water requirements. Various irrigation methods, such as flood irrigation or drip systems, are employed to maintain soil moisture levels. Nutrient management is essential such as nitrogen, phosphorus, and potassium for healthy growth and high yields, with fertilizers applied based on soil nutrient levels and crop requirements. Weed, pest, and disease management practices are employed throughout the growing season to ensure crop health and minimize yield losses. Farmers monitor the crop for signs of stress factors and make timely interventions as needed. When the grains reach maturity, rice is harvested using manual cutting or mechanized methods. Post-harvest processing involves threshing, drying, and milling to produce cleaned, graded, and packaged rice ready for distribution and consumption. Sustainable practices, including water conservation and integrated pest management, are crucial for the long-term sustainability of rice farming.',
    'Mirabel rose farming thrives in India due to its favorable climate and rich tradition in rose cultivation. This practice offers substantial economic benefits, driven by high demand both locally and globally. It also provides employment opportunities and contributes to environmental conservation efforts, thanks to its soil-preserving qualities and low water requirements. Successful Mirabel rose farming relies on specific soil conditions and planting techniques, with meticulous land preparation being crucial. Drip irrigation ensures optimal moisture levels, while organic fertilization enhances soil fertility. Pruning post-flowering enhances yield, although diseases like powdery mildew and black spot pose challenges. To tap into the market, farmers can engage local florists, participate in farmers markets, or explore online sales platforms domestically. Internationally, collaboration with exporters and online marketplaces, along with participation in global flower fairs, can expand market reach. Overall, Mirabel rose farming in India embodies a harmonious blend of economic prosperity and environmental sustainability.',
    'Dairy farming in India has surged in importance due to its role in providing essential nutrients, offering employment opportunities, and contributing significantly to the economy as the worlds largest milk producer. Starting a dairy farm entails costs such as land, infrastructure, cattle, feed, labor, and miscellaneous expenses, with a basic setup for ten cows requiring an investment of approximately INR 10,00,000 to INR 15,00,000. The industry presents promising prospects with growing demand, profitability, government support, and various dairy farming methods catering to different needs. By crafting a strategic business plan, selecting appropriate cattle breeds, and managing costs effectively, aspiring dairy farmers can embark on a rewarding journey while contributing to Indias dairy sector. Additionally, ensuring a consistent and clean water supply for cattle is essential for maintaining their health and productivity.',
    'Vegetable farming is a crucial contributor to Indias economy, offering high profit margins, export opportunities, and employment generation. With top-producing states including West Bengal, Uttar Pradesh, Bihar, Andhra Pradesh, and Madhya Pradesh, India ranks as the worlds second-largest vegetable producer, cultivating staples like ginger, okra, potato, onion, tomato, and more. This sectors importance lies in its ability to ensure food security and support healthier lifestyles amidst changing consumption patterns. Efficient insect and disease control, along with responsive marketing strategies, are key to sustaining profitability in this dynamic market.',
    'Plantation farming, a hallmark of tropical and subtropical regions, stands out for its large-scale operations focused on cultivating a single crop or a narrow range of related crops. This agricultural practice, characterized by vast estates and mechanized operations, plays a crucial role in Indias economy, with states like Assam, Kerala, Tamil Nadu, Karnataka, and West Bengal emerging as key players in tea, coffee, rubber, oil palm, and jute production. Despite its economic significance in providing income and ensuring food security, plantation farming faces scrutiny due to its reliance on imported inputs, low wages, poor working conditions, and environmental impact. The cultivation of tea, coffee, rubber, oil palm, and jute serves as the backbone of plantation agriculture in India, strategically distributed across different regions. From the lush tea gardens of Assam to the sprawling coffee plantations of Karnataka and the rubber estates of Kerala, each crop contributes significantly to both the countrys export earnings and the livelihoods of millions. However, the sectors sustainability is under question as concerns persist regarding its environmental footprint and social implications, underscoring the need for balanced development in this vital aspect of Indias agricultural landscape.',
    'Mushroom farming, also known as myciculture, involves controlled cultivation of mushrooms using organic substrates or synthetic materials instead of sunlight or soil. It begins with selecting suitable species based on market demand and climatic conditions. The process includes substrate preparation, inoculation, incubation, fruiting, and harvesting. Mushroom farming offers advantages like low capital investment, rapid growth cycles, and high yields. However, it requires careful attention to environmental factors and disease management. Despite challenges, it presents a lucrative opportunity for small-scale farmers and entrepreneurs to contribute to food security and sustainability.',
    'Sugarcane thrives in hot, sunny tropical regions with ample rainfall or irrigation, needing a long, warm growing season and high solar radiation.',
  ];

  final List<List<String>> fertilizerNames = [
    [
      'Paddy',
      'NUTRI-RICE',
    ],
    [
      'Downy Mildew',
      'Rose Black Spot',
    ],
    [
      'Weather',
      'Vaccine',
    ],
    [
      'Vegetable Fertilizer',
      'Vegetable Booster',
    ],
    [
      'Areca Special',
      'ANSHUL ARECA STAR',
    ],
    [
      'Weather',
      'Material',
    ],
    [
      'Parle Ropvatika',
      'Sugarcane Booster',
    ],
  ];

  final List<List<String>> fertilisersImages = [
    [
      'assets/images/Fertilisers/batha-1.jpg',
      'assets/images/Fertilisers/batha.jpg',
    ],
    [
      'assets/images/Fertilisers/Rose-Downy-Raze.jpg',
      'assets/images/Fertilisers/Rose-Black-Spot.jpg',
    ],
    [
      'assets/images/Fertilisers/Dairy-weather.jpg',
      'assets/images/Fertilisers/Cowvaccine.jpg',
    ],
    [
      'assets/images/Fertilisers/vegi-1.webp',
      'assets/images/Fertilisers/vegi-2.jpg',
    ],
    [
      'assets/images/Fertilisers/betel_Ferti_1.png',
      'assets/images/Fertilisers/betel_Ferti_2.png',
    ],
    [
      'assets/images/dairy/temperature-range-041723.webp',
      'assets/images/dairy/growroom2.jpg',
    ],
    [
      'assets/images/Fertilisers/sugercane_Ferti_1.jpg',
      'assets/images/Fertilisers/sugercane_Ferti_2.png',
    ],
  ];

  final List<List<String>> fertiliserLinks = [
    [
      'https://www.amazon.in/Agrinex-Eco-Friendly-Organic-Multi-Nutrient-Promoter/dp/B07BHQQL7L',
      'https://excelag.com/nutririce-efficacy-rice/',
    ],
    [
      'https://www.kisanestore.com/downy-raze---downy-mildew-fungicide-500-ml',
      'https://gardenfeast.com.au/product/rose-black-spot-pyrethrum-concentrate-500ml/',
    ],
    [
      'https://www.climatehubs.usda.gov/hubs/northeast/topic/weather-and-climate-considerations-dairy',
      'https://agribegri.com/products/sethu-agroveer-onion-special-booster-plant-growth-regulator.php?utm_source=google&utm_medium=pmax&utm_campaign=PMax:+Smart+All+3000&utm_term=&utm_campaign=PMax:+Smart+All+3000&utm_source=adwords&utm_medium=ppc&hsa_acc=7428009962&hsa_cam=17668524651&hsa_grp=&hsa_ad=&hsa_src=x&hsa_tgt=&hsa_kw=&hsa_mt=&hsa_net=adwords&hsa_ver=3&gad_source=1&gclid=CjwKCAjw8diwBhAbEiwA7i_sJUCR2XTqxBuhzLQmnloMMWV9YPye0liq5GNCZX8HJjI4E80lLTW4xhoCnd0QAvD_BwE',
    ],
    [
      'https://www.urbanplant.in/products/vegetable-fertilizer-for-vegetable-plants-900g',
      'https://www.jiomart.com/p/homeandkitchen/erwon-leafy-vegetable-booster-liquid-fertilizer-premium-essential-powerful-liquid-fertilizer-for-the-best-growth-of-leafy-vegetable-plants/606480343',
    ],
    [
      'https://www.agriplexindia.com/products/dr-soil-new-areca-special-organic-plant-food',
      'https://m.indiamart.com/proddetail/anshul-areca-star-liquid-fertilizer-for-arecanut-2852894068962.html?pos=2&pla=n',
    ],
    [
      'https://jcbgourmetmushrooms.com/blogs/johns-thoughts/how-to-grow-mushrooms-indoors-during-the-summer',
      'https://krishi.icar.gov.in/PDF/Selected_Tech/horticulture/25-Horticulture-Mushroom(white%20button)%20cultivation.pdf',
    ],
    [
      'https://www.amazon.in/Parle-Ropvatika-Sugarcane-Essential-Fertilizer/dp/B0BNXWG83N?th=1',
      'https://agribegri.com/products/sethu-agroveer-liquid-sugarcane-booster-plant-growth-promoter.php?utm_source=google&utm_medium=pmax&utm_campaign=PMax:+Smart+All+3000&utm_term=&utm_campaign=PMax:+Smart+All+3000&utm_source=adwords&utm_medium=ppc&hsa_acc=7428009962&hsa_cam=17668524651&hsa_grp=&hsa_ad=&hsa_src=x&hsa_tgt=&hsa_kw=&hsa_mt=&hsa_net=adwords&hsa_ver=3&gad_source=1&gclid=CjwKCAjw8diwBhAbEiwA7i_sJXQwJCEdzkQ8ImTkoV6apHUvekham8EE6-arS6U-z9xtxSC7eWagdRoCVRQQAvD_BwE',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
            itemCount: 7,
            itemBuilder: (context, index) {
              return Container(
                width: 170,
                margin: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 120,
                      child: ClipRRect(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(8.0),
                        //   topRight: Radius.circular(8.0),
                        // ),
                        child: Image.asset(
                          imageUrls[index],
                          fit: BoxFit.cover,
                        ),
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
                        height: 60,
                        child: Text(
                          blogdescriptions[index],
                          style: TextStyle(fontSize: 14),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  title: blogtitles[index],
                                  relatedvideos: relatedVideos[index],
                                  description: blogdescriptions[index],
                                  imageUrl: imageUrls[index],
                                  fertilizerNames: fertilizerNames[index],
                                  fertiliserlinks: fertiliserLinks[index],
                                  fertilisersImages: fertilisersImages[index],
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            "Read More",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
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

class DetailPage extends StatelessWidget {
  final String title;
  final String relatedvideos;
  final String description;
  final String imageUrl;
  final List<String> fertilizerNames;
  final List<String> fertiliserlinks;
  final List<String> fertilisersImages;

  const DetailPage({
    required this.title,
    required this.relatedvideos,
    required this.description,
    required this.imageUrl,
    required this.fertilizerNames,
    required this.fertiliserlinks,
    required this.fertilisersImages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50, child: Container(color: Colors.green)),
            Container(
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  FutureBuilder(
                    future: _getImageUrl(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return GestureDetector(
                        onTap: () {
                          _showUserProfileDialog(context);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: snapshot.hasData
                                  ? NetworkImage(snapshot.data!)
                                  : AssetImage(
                                          'assets/images/login/person-profile-icon.png')
                                      as ImageProvider<Object>,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${FirebaseAuth.instance.currentUser!.displayName}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: Color(0xFF779D07),
                      ),
                      // SizedBox(width: 5),
                      // Text('Location'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: WeatherWidget(),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with title and description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              8.0), // Set the radius for the top-left corner
                          topRight: Radius.circular(
                              8.0), // Set the radius for the top-right corner
                        ),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              height: 180,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Fertilisers",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Build Clickable Image for each fertilizer
                      for (int i = 0; i < fertilizerNames.length; i++)
                        _buildClickableImage(
                          imageUrl: fertilisersImages[i],
                          text: fertilizerNames[i],
                          url: fertiliserlinks[i],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Related Videos",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 20),
                    YoutubePlayerIFrame(
                      controller: YoutubePlayerController(
                        initialVideoId: relatedvideos,
                        params: YoutubePlayerParams(
                            showControls: true,
                            showFullscreenButton: true,
                            autoPlay: false),
                      ),
                    ),
                  ],
                )),
            Container(
              // height: 52, // Adjust height as needed
              padding: EdgeInsets.symmetric(
                  vertical: 20), // Adjust vertical padding as needed
              // Button
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FarmersList()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Talk to Experts',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableImage({
    required String imageUrl,
    required String text,
    required String url,
  }) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Column(
        children: [
          Image.asset(
            imageUrl,
            height: 100, // Adjust as needed
            width: 100, // Adjust as needed
          ),
          SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showUserProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: _getImageUrl(), // Fetch the image URL from Firebase Storage
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return AlertDialog(
              title: Text('Your Profile'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        // Display the uploaded profile image or default image
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: snapshot.hasData
                              ? NetworkImage(snapshot.data!)
                              : AssetImage(
                                      'assets/images/login/person-profile-icon.png')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _uploadImage(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 30,
                                color: Color(0xFF779D07),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Full Name: ${FirebaseAuth.instance.currentUser!.displayName}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Email: ${FirebaseAuth.instance.currentUser!.email}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color(0xFF779D07),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Color(0xFF779D07),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to get the image URL from Firebase Storage
  Future<String> _getImageUrl() async {
    String imageUrl = ''; // Default empty URL

    // Fetch the image URL from Firebase Storage based on user's UID
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images/${FirebaseAuth.instance.currentUser!.uid}');
    imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }

  void _uploadImage(BuildContext context) async {
    final _picker = ImagePicker();
    XFile? image;

    // Pick an image from gallery
    image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Upload image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${FirebaseAuth.instance.currentUser!.uid}');
      UploadTask uploadTask = storageReference.putFile(File(image.path));

      // Get download URL
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();

        // Update user profile image URL in Firestore or Realtime Database
        // Example:
        // await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        //   'profileImageUrl': imageUrl,
        // });
        // or
        // await FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser!.uid}/profileImageUrl').set(imageUrl);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image uploaded successfully.'),
        ));
      }).catchError((error) {
        // Handle upload errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload image: $error'),
        ));
      });
    }
  }
}
