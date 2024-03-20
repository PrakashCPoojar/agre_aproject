import 'package:flutter/material.dart';
import 'package:agre_aproject/agreculture_app/calendar.dart';

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
      home: DealerPage(),
    );
  }
}

class DealerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dealers'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              farmers(),
              // Fourth Row
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Padding(
                  padding:
                      EdgeInsets.all(4.0), // Add padding around the Text widget
                  child: Text(
                    'John Deere 5310',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set the text color to green
                    ),
                  ),
                ),
              ),
              Farmersdetailssection(),
            ],
          ),
        ),
      ),
    );
  }
}

class farmers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap action here
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side image
            Container(
              width: 200,
              height: 220,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('assets/images/tools/tractor.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Right side text
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Agro industry',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10), // Add some vertical space
                    // Text
                    Text(
                      'We sell tractors with all equepments',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    SizedBox(height: 5), // Add some vertical space
                    // Additional text
                    Text(
                      'Address: Industrial Estate, PB Rd, Manjunath Nagar, Haveri, Karnataka 581110',
                      style: TextStyle(
                        fontSize: 12,
                        // color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone, // Choose your desired icon
                            color: Theme.of(context)
                                .primaryColor, // Use the primary color of your app for the icon
                            size: 16, // Adjust the size of the icon as needed
                          ),
                          SizedBox(
                              width:
                                  10), // Add some space between the icon and the text
                          Text(
                            '+91 9845510000',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email, // Choose your desired icon
                            color: Theme.of(context)
                                .primaryColor, // Use the primary color of your app for the icon
                            size: 16, // Adjust the size of the icon as needed
                          ),
                          SizedBox(
                              width:
                                  10), // Add some space between the icon and the text
                        ],
                      ),
                    ),
                    Text(
                      'agroindustry_hvr@gmail.com',
                      style: TextStyle(
                        fontSize: 12,
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

class Farmersdetailssection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: 1, // Assuming you want 5 items
      itemBuilder: (context, index) {
        return SizedBox(
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  // Table with 2 columns and 8 rows
                  Table(
                    border: TableBorder.all(color: Colors.grey),
                    columnWidths: {
                      0: FlexColumnWidth(
                          1), // Adjust the width of the first column
                      1: FlexColumnWidth(
                          2), // Adjust the width of the second column
                    },
                    children: [
                      buildTableRow('Brand', 'John Deere Tractors'),
                      buildTableRow('No. Of Cylinder', '3'),
                      buildTableRow('HP Category', '55 HP'),
                      buildTableRow('PTO HP', '46.7 HP'),
                      buildTableRow('Gear Box', '9 Forward + 3 Reverse'),
                      buildTableRow('Brakes',
                          'Self adjusting and self equalising, Hydraulically actuated, Oil Immersed Disc Brakes'),
                      buildTableRow('Warranty', '5000 Hours/ 5 Year'),
                      buildTableRow('Price', 'Check Price'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TableRow buildTableRow(String title, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
