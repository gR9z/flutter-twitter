import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

Widget navbarIcon(IconData icon) {
  return IconButton(
    onPressed: () {},
    icon: Icon(
      icon,
      color: Colors.white,
      size: 28.0,
    ),
  );
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryGradientDecoration,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navbarIcon(Icons.create),
            navbarIcon(Icons.home),
            navbarIcon(Icons.search),
          ],
        ),
      ),
    );
  }
}
