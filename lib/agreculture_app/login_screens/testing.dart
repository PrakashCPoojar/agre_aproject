// Verticle

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CropsData());
}

class CropsData extends StatelessWidget {
  const CropsData({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RealTimeData(),
    );
  }
}

class RealTimeData extends StatelessWidget {
  RealTimeData({Key? key});
  final ref = FirebaseDatabase.instance.ref("crop");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Real time data fetching")),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side: Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Container(
                            width: 200,
                            height: 200,
                            margin: EdgeInsets.only(right: 16.0),
                            child: Image.network(
                              snapshot.child("image").value.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Right side: Title and Description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                snapshot.child("name").value.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4), // Spacer
                              // Description
                              Text(
                                snapshot.child("description").value.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
