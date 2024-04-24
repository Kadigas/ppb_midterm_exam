import 'package:flutter/material.dart';

class MoviesFormWidget extends StatelessWidget {
  final bool? isFavorite;
  final int? rating;
  // final String? filepath;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedFavorite;
  // final ValueChanged<String> onChangedFilepath;
  final ValueChanged<int> onChangedRating;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const MoviesFormWidget({
    super.key,
    this.isFavorite = false,
    // this.filepath = 'image404.jpg',
    this.rating = 0,
    this.title = '',
    this.description = '',
    required this.onChangedFavorite,
    // required this.onChangedFilepath,
    required this.onChangedRating,
    required this.onChangedTitle,
    required this.onChangedDescription,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add to Favorite',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Switch(
                value: isFavorite ?? false,
                onChanged: onChangedFavorite,
                activeColor: Colors.yellow,
              ),
            ],
          ),
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Rating: ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Slider(
                  value: (rating ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (rating) => onChangedRating(rating.toInt()),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.white70),
      errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty!' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.white, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.white70),
      errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty!'
        : null,
    onChanged: onChangedDescription,
  );
}