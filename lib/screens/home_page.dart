import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movies/movies_bloc.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  MoviesBloc movieBloc;

  int index = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        movieBloc.add(FetchMovies());
      }
    });

    movieBloc = BlocProvider.of<MoviesBloc>(context);
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

              return Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,),
                  child: AnimSearchBar(
                    width: 400,
                    textController: textController,
                    color: Colors.red,
                    prefixIcon: Icon(Icons.search),   
                    onSuffixTap: () {
                      setState(() {
                        textController.clear();
                      });
                      Navigator.of(context).pushNamed('/searchMovie', arguments: null);
                    },
                  ),
                ),
                Expanded(child: buildMovies(state)),
              ]);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget buildMovies(state) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Container(),
        controller: _scrollController,
        itemCount:
            state.hasReachedMax ? state.movies.length : state.movies.length + 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index == state.movies.length) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/movieDetails',
                      arguments: state.movies[index].id),
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
