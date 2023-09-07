import 'dart:ui';
import 'package:movie_app/my_flutter_app_icons.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:core';

class movieCard extends StatefulWidget {
  final Map mv;
  final List genre;
  TMDB tmdb;
  final int index;
  movieCard(
      {Key? key,
      required this.mv,
      required this.genre,
      required this.tmdb,
      required this.index})
      : super(key: key);

  @override
  State<movieCard> createState() => _movieCardState();
}

class _movieCardState extends State<movieCard> {
  final List<String> genreData = [];
  Map Details = {};

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    Map tmp = await widget.tmdb.v3.movies.getDetails(widget.mv['id'].toInt());
    setState(() {
      Details = tmp;
    });
  }

  Future<Map<dynamic, dynamic>> mm() async {
    return await widget.tmdb.v3.movies.getDetails(widget.mv['id'].toInt());
  }

  pr() {
    List tmp = widget.mv['genre_ids'];
    int gl = widget.genre.length.toInt();
    widget.genre.forEach((gnr) {
      tmp.forEach((movie) {
        if (gnr['id'] == movie) genreData.add(gnr['name']);
      });
    });
    // print("/////");
    print(Details);
  }

  genrePrint() {
    // genreData.forEach((element) {
    // print(element);
    // });
    // int s = genreData.length;
    // print(s);
    // print(mv);
    // for (int i = 0; i < genreData.length.toInt(); i++)
    // print(Details['id']);
    // print(Details['title']);
    // print(Details['release_date']);
    // print(Details['/////']);
  }

  @override
  Widget build(BuildContext context) {
    // pr();
    // genrePrint();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 90, 74, 74),
          title: Text("Movie detail"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                ))
          ],
        ),
        body: FutureBuilder(
          future: mm(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Map Data = snapshot.data as Map;
                print(Data);
                print((widget.mv['vote_average'] / 2.0));
                print(widget.mv['vote_average'] * 1.0);
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 18),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  "https://images.tmdb.org/t/p/w500" +
                                      Data['poster_path'],
                                  width: 235,
                                  //fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /////RATING//////
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, top: 30, right: 20),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(60, 90, 74, 74),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4, left: 8),
                                          child: Row(
                                            children: [
                                              Container(
                                                // alignment: Alignment.center,
                                                height: 28,
                                                width: 31,
                                                child: Icon(
                                                  Icons.videocam,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Opacity(
                                                  opacity: 0.7,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6),
                                                    child: Text(
                                                      "Duration",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          Data['runtime'].toString() + " min",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 8),
                                          child: Row(
                                            children: [
                                              Container(
                                                // alignment: Alignment.center,
                                                height: 32,
                                                width: 31,
                                                child: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Opacity(
                                                  opacity: 0.7,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Text(
                                                      "Release",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          Data['release_date'],
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                /////GENRE/////
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    right: 20,
                                    bottom: 8,
                                  ),
                                  child: Container(
                                    height: 105,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(125, 90, 74, 74),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 25,
                                          child: Icon(
                                            MyFlutterApp.popcorn_svgrepo_com,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: const Opacity(
                                            opacity: 0.8,
                                            child: Text(
                                              "Genre",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  height: 1),
                                            ),
                                          ),
                                        ),
                                        getFilmGenre(Data['genres'])
                                      ],
                                    ),
                                  ),
                                ),
                                //////DURATION//////
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 20),
                                  child: Container(
                                    height: 105,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(200, 90, 74, 74),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: Row(children: [
                                            Container(
                                              // alignment: Alignment.center,
                                              height: 28,
                                              width: 31,
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Opacity(
                                                opacity: 0.7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6),
                                                  child: Text(
                                                    "Rating",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Text(
                                          widget.mv['vote_average']
                                              .toStringAsFixed(1),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        RatingBar.builder(
                                          allowHalfRating: true,
                                          itemSize: 18,
                                          initialRating:
                                              widget.mv['vote_average'] / 2.0,
                                          itemCount: 5,
                                          direction: Axis.horizontal,
                                          onRatingUpdate: (value) {},
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 5,
                                          ),
                                          // initialRating: Data[''],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 15),
                          child: ['', 0, null].contains(Data['name'])
                              ? Text(Data['title'],
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))
                              : Text(Data['name'],
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Divider(
                            color: Colors.black,
                            indent: 20,
                            thickness: 1.5,
                            endIndent: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Text(
                            Data['overview'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                        )
                      ],
                    );
                  },
                );
              } else
                return Center(child: Text("Error"));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

pr(String s) {
  print(s);
}

Widget getFilmGenre(List genre) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      // genre.forEach((element) {
      //   print(element['name']);
      // }),
      for (int i = 0; i < genre.length && i < 3; i++) ...[
        if (['', 0, null].contains(genre[i]['name'])) pr("empty"),
        Text(genre[i]['name'],
            style: TextStyle(fontSize: 14, color: Colors.white, height: 1.2)),
      ]
    ],
  );
}
