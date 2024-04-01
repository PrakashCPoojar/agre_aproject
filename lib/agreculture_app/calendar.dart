import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:agre_aproject/agreculture_app/home.dart';

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
  void initState() {
    super.initState();
    // _selectedTime = SuggestedTimes().suggestedTimes.first;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select date'),
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
                    color: Theme.of(context).primaryColor,
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
              SizedBox(height: 200),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                    print(
                        'Selected date: $_selectedDay, Selected time: $_selectedTime');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
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

  const SuggestedTimes(
      {required this.onTimeSelected,
      Key? key,
      this.suggestedTimes = const [
        '9:00 AM',
        '11:00 AM',
        '2:00 PM',
        '4:00 PM',
        '6:00 PM',
      ]})
      : super(key: key);

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: widget.suggestedTimes
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
                        color:
                            _selectedTime == time ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
