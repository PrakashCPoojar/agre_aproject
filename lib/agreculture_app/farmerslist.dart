import 'dart:io';

import 'package:agre_aproject/agreculture_app/calendar.dart';
import 'package:agre_aproject/agreculture_app/farmerslist.dart';
import 'package:agre_aproject/agreculture_app/login_screens/homepagecontent.dart';
import 'package:agre_aproject/agreculture_app/login_screens/weather.dart';
import 'package:agre_aproject/agreculture_app/login_screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: FarmersList(),
    );
  }
}

class FarmersList extends StatelessWidget {
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
    final ref = FirebaseDatabase.instance.ref("farmers");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          // Background color for the entire page
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // First Row
                Container(
                  height: 50,
                  color: Color(0xFF779D07),
                ),
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
                                // half of the desired width/height
                                child: CircleAvatar(
                                  radius: 16, // reduced the radius
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
                SizedBox(height: 16), // Added SizedBox for spacing
                Container(
                  height: 200,
                  child: WeatherWidget(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      1.05, // Adjust height dynamically
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Agriculture Experts",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0), // Added SizedBox for spacing
                        Expanded(
                          child: FirebaseAnimatedList(
                            physics:
                                NeverScrollableScrollPhysics(), // Disable scrolling
                            query: ref,
                            itemBuilder: (context, snapshot, animation, index) {
                              return CropCard(
                                name: snapshot.child("name").value.toString(),
                                description:
                                    snapshot.child("lan").value.toString(),
                                imageUrl:
                                    snapshot.child("image").value.toString(),
                                location:
                                    snapshot.child("location").value.toString(),
                                specialization: snapshot
                                    .child("specialization")
                                    .value
                                    .toString(),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        // Return ViewMorePage with the provided data
                                        return ViewMorePage(
                                          name: snapshot
                                              .child("name")
                                              .value
                                              .toString(),
                                          video: snapshot
                                              .child("video")
                                              .value
                                              .toString(),
                                          description: snapshot
                                              .child("lan")
                                              .value
                                              .toString(),
                                          imageUrl: snapshot
                                              .child("image")
                                              .value
                                              .toString(),
                                          location: snapshot
                                              .child("location")
                                              .value
                                              .toString(),
                                          specialization: snapshot
                                              .child("specialization")
                                              .value
                                              .toString(),
                                          phone: snapshot
                                              .child("phone")
                                              .value
                                              .toString(),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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

class CropCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final String specialization;
  final VoidCallback onPressed;

  const CropCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.specialization,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: Image (30% width)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 155,
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
            SizedBox(width: 16), // Adjusted width to reduce space
            // Right side: Name, Description, and Button (70% width)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
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
                    // SizedBox(height: 4), // Adjusted height to reduce space
                    // // Description
                    // Text(
                    //   'Language: ' + description,
                    //   style: TextStyle(fontSize: 16),
                    //   maxLines: 3,
                    //   overflow: TextOverflow.ellipsis,
                    //   textAlign: TextAlign.justify,
                    // ),
                    SizedBox(height: 4), // Adjusted height to reduce space
                    // Description
                    Text(
                      'Location: ' + location,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 4), // Adjusted height to reduce space
                    // Description
                    Text(
                      specialization,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 8), // Adjusted height to reduce space
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
                              topLeft: Radius.circular(16.0),
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
                          'Book a Slot',
                          style: TextStyle(color: Colors.white),
                        ),
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
  }
}

class ViewMorePage extends StatelessWidget {
  final String name;
  final String video;
  final String description;
  final String location;
  final String specialization;
  final String phone;
  final String imageUrl;

  const ViewMorePage({
    required this.name,
    required this.video,
    required this.description,
    required this.location,
    required this.specialization,
    required this.phone,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50, child: Container(color: Color(0xFF779D07))),
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
                child:
                    WeatherWidget(), // Replace Placeholder with your WeatherWidget
              ),
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
                        name.replaceFirst(name[0], name[0].toUpperCase()),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Know Langiage: ' + description,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Location: ' + location,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description\
                    SizedBox(height: 8),
                    // Description
                    GestureDetector(
                      onTap: () {
                        launch('tel://${phone}');
                      },
                      child: Row(
                        children: [
                          Text(
                            'Mobile: ' + phone,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.phone,
                            size: 24,
                            color: Color(0xFF779D07),
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Specilization: ' + specialization,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    SizedBox(height: 8),

                    Container(
                        // padding: EdgeInsets.all(.0),
                        child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Related Videos",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 20),
                        YoutubePlayerIFrame(
                          controller: YoutubePlayerController(
                            initialVideoId: video,
                            params: YoutubePlayerParams(
                                showControls: true,
                                showFullscreenButton: true,
                                autoPlay: false),
                          ),
                        ),
                      ],
                    )),

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
                                  builder: (context) => CalendarPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Color(0xFF779D07),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          child: Text(
                            'Book a Appointment',
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
