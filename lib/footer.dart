
import 'package:flutter/material.dart';

import 'main.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Fil", style: TextStyle(color: secondaryBGColor)),
            Text("Notification", style: footerTextStyle),
            Text("Message", style: footerTextStyle),
            Text("Moi", style: footerTextStyle),
          ],
        ),
      ),
    );
  }
}
