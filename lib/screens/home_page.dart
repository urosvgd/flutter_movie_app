import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movies/movies_bloc.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController bottomController = PageController(
    initialPage: 0,
    viewportFraction: .2,
  );
  MoviesBloc movieBloc;

  PageController pageController = PageController(initialPage: 0);

  int index = 0;
  final scrollThreshold = 200;

  @override
  void initState() {
    super.initState();
    bottomController.addListener(_onScroll);
    movieBloc = BlocProvider.of<MoviesBloc>(context);
  }

  void _onScroll() {
    final maxScroll = bottomController.position.maxScrollExtent;
    final currentScroll = bottomController.position.pixels;

    if (maxScroll - currentScroll <= scrollThreshold) {
      movieBloc.add(FetchMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e0e0e),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MoviesFailed) {
              return Center(
                child: Text('There was a problem..'),
              );
            }

            if (state is MoviesSuccess) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text('No Movies'),
                );
              }

              return buildMovies(state);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildMovies(state) {
    return ListView.builder(
        itemCount: state.movies.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/movieDetails',
                      arguments: state.movies[index]),
                  child: Container(
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500/${state.movies[index].poster_path}",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
