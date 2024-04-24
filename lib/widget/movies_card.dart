import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midterm_exam/model/movies.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    super.key,
    required this.movie,
    required this.index,
  });

  final Movie movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    // final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(movie.createdTime);
    // final minHeight = getMinHeight(index);

    IconData? icon = movie.isFavorite ? Icons.star : null;


    return Card(
      color: Colors.grey.shade900,
      child: Container(
        constraints: BoxConstraints(minHeight: 150),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              child: Image.network('https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'),
              ),
            Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 4),
            Text(
              'Ratings: ${movie.rating.toString()}/5',
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  // double getMinHeight(int index) {
  //   switch (index % 4) {
  //     case 0:
  //       return 100;
  //     case 1:
  //       return 150;
  //     case 2:
  //       return 150;
  //     case 3:
  //       return 100;
  //     default:
  //       return 100;
  //   }
  // }
}