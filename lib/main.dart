import 'package:flutter/material.dart';
import 'pages/songs_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Crud',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SongsListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
