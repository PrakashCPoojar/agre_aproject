import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender {
  static Future<void> sendEmail(BuildContext context) async {
    String username = '2022mt93001@gmail.com'; // Your Gmail address
    String password = 'gjjt lcqu beeq xror'; // Your Gmail password

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Prakash') // Your name
      ..recipients.add('prakashpujar00@gmail.com') // Recipient's email address
      ..subject = 'Your booking is confirmed'
      ..text =
          'This is a test email sent from Flutter with Firebase and Gmail SMTP';

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email sent successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      // Navigate to home page
      Navigator.of(context).pop();
    } catch (e) {
      print('Error sending email: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send email. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class SendEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        EmailSender.sendEmail(context);
      },
      child: Text('Send Email'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Send Email Button'),
      ),
      body: Center(
        child: SendEmailButton(),
      ),
    ),
  ));
}
