import 'package:agre_aproject/agreculture_app/login_screens/homepagecontent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:agre_aproject/agreculture_app/home.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() {
  runApp(CalendarPage());
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};
  late String _selectedTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Please select date'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2021, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                enabledDayPredicate: (DateTime day) {
                  final today = DateTime.now();
                  return !day.isBefore(today.subtract(Duration(days: 1)));
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF779D07),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Suggested Times:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SuggestedTimes(
                onTimeSelected: (selectedTime) {
                  setState(() {
                    _selectedTime = selectedTime;
                  });
                },
              ),
              SizedBox(height: 150),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedDay != null && _selectedTime != null) {
                      try {
                        await EmailSender.sendEmail(
                            _selectedDay!, _selectedTime);
                        // Show success snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email sent successfully'),
                            backgroundColor: Color(0xFF779D07),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      } catch (e) {
                        // Show error snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error sending email: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      // Show snackbar indicating that the date or time is not selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a date and time'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Color(0xFF779D07),
                    padding: EdgeInsets.symmetric(
                      horizontal: 68,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuggestedTimes extends StatefulWidget {
  final List<String> suggestedTimes;
  final Function(String) onTimeSelected;

  const SuggestedTimes({
    required this.onTimeSelected,
    Key? key,
    this.suggestedTimes = const [
      '9:00 AM',
      '11:00 AM',
      '2:00 PM',
      '4:00 PM',
      '6:00 PM',
      '8:00 PM',
    ],
  }) : super(key: key);

  @override
  _SuggestedTimesState createState() => _SuggestedTimesState();
}

class _SuggestedTimesState extends State<SuggestedTimes> {
  late String _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.suggestedTimes.first;
  }

  @override
  Widget build(BuildContext context) {
    int splitIndex = widget.suggestedTimes.length ~/ 3;
    List<String> firstThird = widget.suggestedTimes.sublist(0, splitIndex);
    List<String> secondThird =
        widget.suggestedTimes.sublist(splitIndex, splitIndex * 2);
    List<String> thirdThird = widget.suggestedTimes.sublist(splitIndex * 2);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            children: firstThird
                .map((time) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTime = time;
                          });
                          widget.onTimeSelected(time);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedTime == time
                              ? Color(0xFF779D07)
                              : Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: _selectedTime == time
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Column(
            children: secondThird
                .map((time) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTime = time;
                          });
                          widget.onTimeSelected(time);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedTime == time
                              ? Color(0xFF779D07)
                              : Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: _selectedTime == time
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Column(
            children: thirdThird
                .map((time) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTime = time;
                          });
                          widget.onTimeSelected(time);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedTime == time
                              ? Color(0xFF779D07)
                              : Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: _selectedTime == time
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class EmailSender {
  final User = FirebaseAuth.instance.currentUser;
  static Future<void> sendEmail(
      DateTime? selectedDay, String selectedTime) async {
    String username = '2022mt93001@gmail.com'; // Your Gmail address
    String password = 'gjjt lcqu beeq xror'; // Your Gmail password

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Agriculture App') // Your name
      ..recipients.add(
          '${FirebaseAuth.instance.currentUser!.email}') // Recipient's email address
      ..subject = 'Your booking is confirmed'
      ..text = 'Your booking details with agriculture expert on .\n\n'
          'Date: $selectedDay\n'
          'Time: $selectedTime. \n\n'
          'Regards,\n'
          'BITS Student (2022mt93001)';

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
