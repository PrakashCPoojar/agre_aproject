import 'dart:io';

import 'package:agre_aproject/agreculture_app/farmerslist.dart';
import 'package:agre_aproject/agreculture_app/login_screens/weather.dart';
import 'package:agre_aproject/agreculture_app/login_screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weather/weather.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          // Background color for the entire page
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // First Row
                SizedBox(
                    height: 50, child: Container(color: Color(0xFF779D07))),
                SizedBox(
                  height: 50,
                  child: Container(
                    height: 50,
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
                                  // half of the desired width/height
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
                ),
                SizedBox(
                  height: 200,
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.zero,
                    child: WeatherWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: Container(
                    // height: 850,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Crops Details",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0),
                        Container(
                          height: 535,
                          child: SoilData(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

class SoilData extends StatelessWidget {
  SoilData({Key? key});
  final ref = FirebaseDatabase.instance.ref("tools");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return CropCard(
                    name: snapshot.child("name").value.toString(),
                    description: snapshot.child("description").value.toString(),
                    imageUrl: snapshot.child("image").value.toString(),
                    price: snapshot.child("price").value.toString(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // Retrieve suitable crops data
                            List<dynamic>? suitableCropsData = snapshot
                                .child("related")
                                .value as List<dynamic>?;

                            // Check if suitableCropsData is not null before mapping
                            List<String> suitablesCropsNames =
                                suitableCropsData != null
                                    ? List<String>.from(suitableCropsData
                                        .map((crop) => crop["name"].toString()))
                                    : [];

                            List<String> suitablesCropsImages =
                                suitableCropsData != null
                                    ? List<String>.from(suitableCropsData.map(
                                        (crop) => crop["image"].toString()))
                                    : [];

                            List<String> suitablesCropsLink =
                                suitableCropsData != null
                                    ? List<String>.from(suitableCropsData
                                        .map((crop) => crop["link"].toString()))
                                    : [];

                            // Return ViewMorePage with the provided data
                            return ViewMorePage(
                              name: snapshot.child("name").value.toString(),
                              video: snapshot.child("video").value.toString(),
                              description: snapshot
                                  .child("description")
                                  .value
                                  .toString(),
                              imageUrl:
                                  snapshot.child("image").value.toString(),
                              suitablesCropsNames: suitablesCropsNames,
                              suitablesCropsImages: suitablesCropsImages,
                              suitablesCropsLink: suitablesCropsLink,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final VoidCallback onPressed;

  const CropCard({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            // Left side: Image (30% width)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 185,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8),
            // Right side: Name, Description, and Button (70% width)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    name.replaceFirst(name[0], name[0].toUpperCase()),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Description
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 4),
                  // Description
                  Text(
                    'Price: ' + price,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  // Button aligned to the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF779D07), // Set background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8, // Adjusted padding to reduce space
                        ),
                      ),
                      child: Text(
                        'View More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewMorePage extends StatelessWidget {
  final String name;
  final String video;
  final String description;
  final String imageUrl;
  final List<String> suitablesCropsNames;
  final List<String> suitablesCropsImages;
  final List<String> suitablesCropsLink;

  const ViewMorePage({
    required this.name,
    required this.video,
    required this.description,
    required this.imageUrl,
    required this.suitablesCropsNames,
    required this.suitablesCropsImages,
    required this.suitablesCropsLink,
    Key? key,
  }) : super(key: key);

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 50,
                  child: Container(
                    color: Color(0xFF779D07),
                  )),
              Container(
                height: 50,
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
                      '${getFirstName()}',
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
              // Container(
              //   height: 200,
              //   child:
              //       WeatherWidget(), // Replace Placeholder with your WeatherWidget
              // ),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Title
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description
                    Text(
                      description,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    Container(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Related Videos",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: 20),
                            YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: video,
                                flags: YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              progressColors: ProgressBarColors(
                                playedColor: Colors.amber,
                                handleColor: Colors.amberAccent,
                              ),
                              onReady: () {
                                print('Player is ready.');
                              },
                            ),
                          ],
                        )),
                    SizedBox(height: 8),
                    Align(
                      child: Text(
                        'Supporting Tools',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                    ),

                    SizedBox(height: 8),

                    Container(
                      height: 130,
                      color: Colors.white
                          .withOpacity(0.5), // Adjust opacity as needed
                      padding: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: suitablesCropsNames.length,
                        itemBuilder: (context, index) {
                          return _buildClickableImage(
                            imageUrl: suitablesCropsImages[index],
                            text: suitablesCropsNames[index],
                            url: suitablesCropsLink[index],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8),
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
                              MaterialPageRoute(
                                  builder: (context) => FarmersList()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF779D07),
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
            ],
          ),
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 100,
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.black.withOpacity(0.3), // Adjust opacity as needed
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
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
