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
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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
    'assets/images/crops/kabbu.webp',
    'assets/images/crops/jolla.jpeg',
    'assets/images/crops/bath-1.jpg',
    'assets/images/crops/adike.jpg',
    'assets/images/dairy/dairy-farming.jpg',
  ];

  final List<String> blogtitles = [
    'Rice',
    'Sugar cane',
    'Corn',
    'Rice 1001',
    'Betel nut',
    'Dairy'
  ];
  final List<String> relatedVideos = [
    'Pkoov2xIgOA',
    'wdvrzWtkHfA',
    '62NQDNGFOXo',
    'FW_bw9jdrlQ&t=14s',
    'hLMDsVN20F8',
    'Ky2_VtCb-yA',
  ];

  final List<String> blogdescriptions = [
    'Rice is one of the chief grains of India. Moreover, this country has the largest area under rice cultivation. As it is one of the principal food crops. It is, in fact, the dominant crop of the country. India is one of the leading producers of this crop. Rice is the basic food crop and being a tropical plant, it flourishes comfortably in a hot and humid climate.',
    'Sugarcane thrives in hot, sunny tropical regions with ample rainfall or irrigation, needing a long, warm growing season and high solar radiation.',
    'Corn plants have specific soil requirements. Early varieties grow best in sand or loam, while late varieties grow best in silty or clayey types of soil.',
    'Rice is one of the chief grains of India. Moreover, this country has the largest area under rice cultivation. As it is one of the principal food crops. It is, in fact, the dominant crop of the country. India is one of the leading producers of this crop. Rice is the basic food crop and being a tropical plant, it flourishes comfortably in a hot and humid climate.',
    'Seedlings of 1 to 2 years of age should be planted in pits of about 90 x 90 x 90 cm at a spacing of 2.75 to 3.0 meter either way and covered with soil to the collar level of the plants and press the soil around. It is essential to provide shade during summer months.',
    'Dairy farming is a class of agriculture for the long-term production of milk, which is processed (either on the farm or at a dairy plant, either of which may be called a dairy) for the eventual sale of a dairy product. Dairy farming has a history that goes back to the early Neolithic era, around the seventh millennium BC, in many regions of Europe and Africa. Before the 20th century, milking was done by hand on small farms. Beginning in the early 20th century, milking was done in large scale dairy farms with innovations including rotary parlors, the milking pipeline, and automatic milking systems that were commercially developed in the early 1990s.',
  ];

  final List<List<String>> fertilizerNames = [
    [
      'Paddy',
      'NUTRI-RICE',
    ],
    [
      'Parle Ropvatika',
      'Sugarcane Booster',
    ],
    [
      'Paddy',
      'NUTRI-RICE',
    ],
    [
      'Paddy',
      'NUTRI-RICE',
    ],
    [
      'Areca Special',
      'ANSHUL ARECA STAR',
    ],
    [
      'Weather',
      'vaccinated',
    ],
  ];

  final List<List<String>> fertilisersImages = [
    [
      'assets/images/Fertilisers/batha-1.jpg',
      'assets/images/Fertilisers/batha.jpg',
    ],
    [
      'assets/images/Fertilisers/sugercane_Ferti_1.jpg',
      'assets/images/Fertilisers/sugercane_Ferti_2.png',
    ],
    [
      'assets/images/Fertilisers/corn_Ferti_1.png',
      'assets/images/Fertilisers/corn_Ferti_2.png',
    ],
    [
      'assets/images/Fertilisers/batha-1.jpg',
      'assets/images/Fertilisers/batha.jpg',
    ],
    [
      'assets/images/Fertilisers/betel_Ferti_1.png',
      'assets/images/Fertilisers/betel_Ferti_2.png',
    ],
    [
      'assets/images/dairy/Dairy-weather.jpg',
      'assets/images/dairy/Cowvaccine.jpg',
    ],
  ];

  final List<List<String>> fertiliserLinks = [
    [
      'https://www.amazon.in/Agrinex-Eco-Friendly-Organic-Multi-Nutrient-Promoter/dp/B07BHQQL7L',
      'https://excelag.com/nutririce-efficacy-rice/',
    ],
    [
      'https://www.amazon.in/Parle-Ropvatika-Sugarcane-Essential-Fertilizer/dp/B0BNXWG83N?th=1',
      'https://agribegri.com/products/sethu-agroveer-liquid-sugarcane-booster-plant-growth-promoter.php?utm_source=google&utm_medium=pmax&utm_campaign=PMax:+Smart+All+3000&utm_term=&utm_campaign=PMax:+Smart+All+3000&utm_source=adwords&utm_medium=ppc&hsa_acc=7428009962&hsa_cam=17668524651&hsa_grp=&hsa_ad=&hsa_src=x&hsa_tgt=&hsa_kw=&hsa_mt=&hsa_net=adwords&hsa_ver=3&gad_source=1&gclid=CjwKCAjw8diwBhAbEiwA7i_sJXQwJCEdzkQ8ImTkoV6apHUvekham8EE6-arS6U-z9xtxSC7eWagdRoCVRQQAvD_BwE',
    ],
    [
      'https://gogarden.co.in/products/urea-fertilizers-for-plants-46-nitrogen-fertilizer-soil-application-and-100-water-soluble-1',
      'https://agribegri.com/products/sethu-agroveer-onion-special-booster-plant-growth-regulator.php?utm_source=google&utm_medium=pmax&utm_campaign=PMax:+Smart+All+3000&utm_term=&utm_campaign=PMax:+Smart+All+3000&utm_source=adwords&utm_medium=ppc&hsa_acc=7428009962&hsa_cam=17668524651&hsa_grp=&hsa_ad=&hsa_src=x&hsa_tgt=&hsa_kw=&hsa_mt=&hsa_net=adwords&hsa_ver=3&gad_source=1&gclid=CjwKCAjw8diwBhAbEiwA7i_sJUCR2XTqxBuhzLQmnloMMWV9YPye0liq5GNCZX8HJjI4E80lLTW4xhoCnd0QAvD_BwE',
    ],
    [
      'https://www.amazon.in/Agrinex-Eco-Friendly-Organic-Multi-Nutrient-Promoter/dp/B07BHQQL7L',
      'https://excelag.com/nutririce-efficacy-rice/',
    ],
    [
      'https://www.agriplexindia.com/products/dr-soil-new-areca-special-organic-plant-food',
      'https://m.indiamart.com/proddetail/anshul-areca-star-liquid-fertilizer-for-arecanut-2852894068962.html?pos=2&pla=n',
    ],
    [
      'https://www.manage.gov.in/publications/eBooks/Climate%20Smart%20Dairying.pdf',
      'https://vikaspedia.in/agriculture/livestock/cattle-buffalo/vaccination-schedule-in-cattle-and-buffalo',
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
                      width: 200,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
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
