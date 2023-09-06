import 'package:flutter/material.dart';
import 'package:movie_app/trending_movies.dart';
import 'package:movie_app/topRatedMovies.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromARGB(255, 41, 34, 34)),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> trend = [];
  List topRated = [];
  List genreTv = [];
  late TMDB tmdb;
  final apikey = '012e430fc4f04aafc63ae4ab7412b03a';
  final token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTJlNDMwZmM0ZjA0YWFmYzYzYWU0YWI3NDEyYjAzYSIsInN1YiI6IjYyZGUwNjJhMzNhNTMzMDUxZTBhZWJkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kIMeIttzMkN2LePkg4rdXgMtQ3qMXzlv5CiKkOlLHv8';

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    tmdb = TMDB(ApiKeys(apikey, token),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trending = await tmdb.v3.trending.getTrending();
    Map topRatedRes = await tmdb.v3.movies.getTopRated();
    Map genre = await tmdb.v3.genres.getMovieList();
    setState(() {
      trend = trending['results'];
      topRated = topRatedRes['results'];
      genreTv = genre['genres'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Padding²
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 90, 74, 74),
          title: const Text('Movie App'),
        ),
        body: ListView(children: [
          TrendingMovies(abc: trend, genres: genreTv, tmdb: tmdb),
          topRatedMovies(abc: topRated, genres: genreTv, tmdb: tmdb),
          SizedBox(height: 50),
          Opacity(
            opacity: 0.8,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  'By xAn4ss',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          )
        ]));
  }
}
