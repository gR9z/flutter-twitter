import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitterlike/footer.dart';
import 'package:twitterlike/login.dart';
import 'package:twitterlike/tweet-view-model.dart';

import 'main.dart';

Widget makeIconButton(String imageUrl) {
  return IconButton(onPressed: () {}, icon: Image.asset(imageUrl, width: 28));
}

class TwitterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryBGColor,
        title: Text("Messages", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/gradient.jpg", fit: BoxFit.cover),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TweetListWidget(),
                ),
              ),
              FooterWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class TweetListWidget extends StatelessWidget {
  void onClick(BuildContext context) {
    TweetViewModel tweetViewModel = context.read<TweetViewModel>();
    tweetViewModel.onClickRefresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TweetViewModel(),
        builder: (context, child) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onClick(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBGColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(24.0),
                  ),
                  child: Text(
                    "Refresh".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14),
              Expanded(
                child: Consumer<TweetViewModel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      itemCount: viewModel.tweets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tweet = viewModel.tweets[index];
                        return wrapperWithPadding(
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          tweet.profile,
                                          width: 96,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(tweet.author,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    tweet.createdDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: middleGrey,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              tweet.message,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      makeIconButton("images/reply.png"),
                                      makeIconButton("images/retweet.png"),
                                      makeIconButton("images/favorite.png"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          paddingValue: 6,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
