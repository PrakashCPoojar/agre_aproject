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
  const CropsData({super.key});

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
  RealTimeData({super.key});
  final ref = FirebaseDatabase.instance.ref("soil");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Real time data fetchinbg")),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.child("name").value.toString()),
                        subtitle: Text(
                            snapshot.child("description").value.toString()),
                        trailing: Image.network(
                          snapshot
                              .child("image")
                              .value
                              .toString(), // Assuming "url" is the field name for the image URL
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
