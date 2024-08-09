import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:twitterlike/auth-context.dart';
import 'package:twitterlike/tweet.dart';

class TweetViewModel with ChangeNotifier {
  static const allComments = "http://localhost:3000/v2/comment/all";

  List<Tweet> tweets = [
    Tweet(
      4,
      "https://avatar.iran.liara.run/public",
      1722427444,
      "arthur.pendragon@gmail.com",
      "Est-ce que vous connaissez la différence entre un ricanement et un bâillement ? Non parce que moi, là, je suis pas sûr de ce que vous venez de faire.",
    ),
    Tweet(
      5,
      "https://avatar.iran.liara.run/public",
      1722427555,
      "perceval@gmail.com",
      "Mais c'est ce que je dis depuis le début ! Sauf que j'utilise pas les mêmes mots.",
    ),
    Tweet(
      6,
      "https://avatar.iran.liara.run/public",
      1722427666,
      "loth@gmail.com",
      "À force de péter trop haut, le cul prend la place du cerveau.",
    ),
    Tweet(
      7,
      "https://avatar.iran.liara.run/public",
      1722427777,
      "roi.loth@gmail.com",
      "C'est sûr que si on fait un détour par les champs de patates, ça va nous faire arriver en retard, oui !",
    )
  ];

  void onClickRefresh(BuildContext context) async {
    final headers = {'Authorization': 'Bearer ${AuthContext.token}'};

    var pd = ProgressDialog(context: context);

    pd!.show(
        msg: "Refreshing",
        barrierColor: Color(0x77000000),
        progressBgColor: Colors.transparent,
        elevation: 10.0);

    // Simulate delay
    await Future.delayed(Duration(seconds: 1));

    var response = await http.get(Uri.parse(allComments), headers: headers);
    var json = convert.jsonDecode(response.body);

    if (json['code'] == "798") {
      print(json['message']);
    } else {
      tweets = List<Tweet>.from(
          json['data'].map((tweet) => Tweet.fromJson(tweet)).toList());
    }

    pd!.close();
    notifyListeners();
  }
}
