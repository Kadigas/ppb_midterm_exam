import 'package:flutter/material.dart';
import 'package:midterm_exam/db/movies_database.dart';
import 'package:midterm_exam/model/movies.dart';
import 'package:midterm_exam/widget/movies_form.dart';

class AddEditMoviePage extends StatefulWidget {
  final Movie? movie;

  const AddEditMoviePage({
    super.key,
    this.movie,
  });

  @override
  State<AddEditMoviePage> createState() => _AddEditMoviePageState();
}

class _AddEditMoviePageState extends State<AddEditMoviePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isFavorite;
  late String filepath;
  late int rating;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isFavorite = widget.movie?.isFavorite ?? false;
    // filepath = widget.movie?.filepath ?? 'image404.jpg';
    rating = widget.movie?.rating ?? 0;
    title = widget.movie?.title ?? '';
    description = widget.movie?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: MoviesFormWidget (
        isFavorite: isFavorite,
        // filepath: filepath,
        rating: rating,
        title: title,
        description: description,
        onChangedFavorite: (isFavorite) =>
            setState(() => this.isFavorite = isFavorite),
        // onChangedFilepath: (filepath) => setState(() => this.filepath = filepath),
        onChangedRating: (rating) => setState(() => this.rating = rating),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? Colors.orange : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateMovie();
      } else {
        await addMovie();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      isFavorite: isFavorite,
      // filepath: filepath,
      rating: rating,
      title: title,
      description: description,
    );

    await MoviesDatabase.instance.update(movie);
  }

  Future addMovie() async {
    final movie = Movie(
      title: title,
      isFavorite: isFavorite,
      // filepath: filepath,
      rating: rating,
      description: description,
      createdTime: DateTime.now(),
    );

    await MoviesDatabase.instance.create(movie);
  }
}