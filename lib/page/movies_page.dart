import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:midterm_exam/db/movies_database.dart';
import 'package:midterm_exam/model/movies.dart';
import 'package:midterm_exam/db/movies_database.dart';
import 'package:midterm_exam/model/movies.dart';
import 'package:midterm_exam/page/movie_edit_page.dart';
import 'package:midterm_exam/page/movie_detail_page.dart';
import 'package:midterm_exam/widget/movies_card.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List<Movie> movies;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovies();
  }

  @override
  void dispose() {
    MoviesDatabase.instance.close();

    super.dispose();
  }

  Future refreshMovies() async {
    setState(() => isLoading = true);

    movies = await MoviesDatabase.instance.readAll();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Movies',
        style: TextStyle(
            fontSize: 24,
            color: Colors.white
        ),
      ),
      actions: const [Icon(Icons.search, color: Colors.white), SizedBox(width: 12)],
    ),
    body: SingleChildScrollView(
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : movies.isEmpty
            ? const Text(
          'No Movies Added',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
            : buildMovies(),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.orange,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditMoviePage()),
        );

        refreshMovies();
      },
    ),
  );
  Widget buildMovies() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        movies.length, (index) {
          final movie = movies[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movie.id!),
                ));

                refreshMovies();
              },
              child: MovieCardWidget(movie: movie, index: index),
            ),
          );
        },
      ));
}