import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyNewsApp());
}

class MyNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Farmers News'),
        ),
        body: WebView(
          initialUrl:
              'https://vijaykarnataka.com/lavalavk/agri/articlelist/11181621.cms',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
