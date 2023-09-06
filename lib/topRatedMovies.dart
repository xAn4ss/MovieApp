import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Movie_card.dart';
import 'package:tmdb_api/tmdb_api.dart';

class topRatedMovies extends StatelessWidget {
  final List abc;
  final List genres;
  final String named = '';
  TMDB tmdb;
  Map Details = {};
  topRatedMovies(
      {Key? key, required this.abc, required this.genres, required this.tmdb})
      : super(key: key);
  getDetails(int index) async {
    Details = await tmdb.v3.movies.getDetails(abc[index]['id'].toInt());
    // print("*****");
    // print(Details);

    // if (Details.isEmpty){
    //   print(Details);
    // }else
    //   print("Empty");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "TOP RATED",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 360,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: abc.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // getDetails(index);
                    // print(Details);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => movieCard(
                              mv: abc[index],
                              genre: genres,
                              tmdb: tmdb,
                              index: index,
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 280,
                          width: 190,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://images.tmdb.org/t/p/w500" +
                                          abc[index]['poster_path']))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 180,
                            child: Text(
                              ['', 0, null].contains(abc[index]['title'])
                                  ? abc[index]['name']
                                  : abc[index]['title'],
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
