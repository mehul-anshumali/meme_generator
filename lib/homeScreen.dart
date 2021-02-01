import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:share/share.dart';

import 'models/meme.dart';

Future<Meme> loadMeme() async {
  final response = await http.get('https://meme-api.herokuapp.com/gimme');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Meme.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Meme');
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadMeme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    void share(BuildContext context, String url) {
      Share.share('Check out this amazing meme $url');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MEME GENERATOR',
          style: TextStyle(fontSize: 25.0, letterSpacing: 4.0),
        ),
        backgroundColor: Color(0xFF120E43),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: FutureBuilder<Meme>(
          future: loadMeme(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  // here we are showing loading view in waiting state.
                  return CircularProgressIndicator();
                }
              case ConnectionState.active:
                {
                  break;
                }
              case ConnectionState.done:
                {
                  // in done state we will handle the snapshot data.
                  // if snapshot has data show list else set you message.
                  if (snapshot.hasData) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          snapshot.data.imgUrl,
                          height: height * 0.80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height * 0.08,
                              width: width * 0.45,
                              child: RaisedButton(
                                  color: Color(0xFF120E43),
                                  textColor: Colors.white,
                                  child: Text(
                                    'SHARE',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  onPressed: () =>
                                      share(context, snapshot.data.imgUrl)),
                            ),
                            Container(
                              height: height * 0.08,
                              width: width * 0.45,
                              child: RaisedButton(
                                color: Color(0xFF120E43),
                                textColor: Colors.white,
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    loadMeme();
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "Not Connected with Internet!!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  }

                  break;
                }
              case ConnectionState.none:
                {
                  break;
                }
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
