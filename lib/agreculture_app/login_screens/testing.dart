import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileDialog extends StatelessWidget {
  Future<String?> _getImageUrl() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$userId');
      try {
        final url = await storageReference.getDownloadURL();
        return url;
      } catch (error) {
        print('Error fetching image URL: $error');
        return null;
      }
    }
    return null;
  }

  Future<void> _showUserProfileDialog(BuildContext context) async {
    // Fetch the image URL asynchronously
    String? imageUrl = await _getImageUrl();

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
                child: Stack(
                  children: [
                    // Display the uploaded profile image or default image
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage(
                                  'assets/images/login/person-profile-icon.png')
                              as ImageProvider<Object>,
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
  }

  Future<void> _uploadImage(BuildContext context) async {
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
      try {
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
      } catch (error) {
        // Handle upload errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload image: $error'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: _getImageUrl(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loader while fetching image URL
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
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
                      backgroundImage:
                          (snapshot.hasData && snapshot.data != null)
                              ? NetworkImage(snapshot.data!)
                              : AssetImage(
                                  'assets/images/login/person-profile-icon.png',
                                ) as ImageProvider<Object>,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfileDialog(),
  ));
}
