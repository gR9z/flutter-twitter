import 'package:flutter/material.dart';
import 'package:twitterlike/auth/login.dart';
import 'package:twitterlike/home/twitter-list.dart';

const primaryBGColor = Color(0xFF13425E);
const secondaryBGColor = Color(0xFF246A98);
const darkGrey = Color(0xFF58646C);
const lightGrey = Color(0xFFF1F3F6);
const middleGrey = Color(0xFF899398);

const primaryGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      primaryBGColor,
      secondaryBGColor,
    ],
    tileMode: TileMode.mirror,
  ),
);

const headerTextStyle = TextStyle(color: Colors.white);
const footerTextStyle = TextStyle(color: darkGrey);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TwitterLike',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/twitterList",
      routes: {
        "/": (context) => LoginPage(),
        "/twitterList": (context) => TwitterList()
      }
    );
  }
}
