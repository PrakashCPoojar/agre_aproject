// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyNewsApp());
// }

// class MyNewsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Farmers News'),
//         ),
//         body: buildContent(),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }

//   Widget buildContent() {
//     if (kIsWeb) {
//       // For web, return a WebView
//       return webview(
//         initialUrl:
//             'https://vijaykarnataka.com/lavalavk/agri/articlelist/11181621.cms',
//         javascriptMode: JavascriptMode.unrestricted,
//       );
//     } else {
//       // For non-web platforms, return a Flutter widget
//       return HtmlWidget(
//         '<iframe src="https://vijaykarnataka.com/lavalavk/agri/articlelist/11181621.cms" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>',
//         webView: true,
//       );
//     }
//   }
// }
