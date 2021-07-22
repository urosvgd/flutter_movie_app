import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/bloc/cast/cast_bloc.dart';
import 'package:movies_app/bloc/movie_details/movie_details_bloc.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/repository/movie_repository.dart';
import 'package:movies_app/service/movie_api_client.dart';

class MovieDetailsPage extends StatelessWidget {
  final int data;
  MovieDetailsPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieRepository movieRepository =
        MovieRepository(apiClient: ApiClient(httpClient: http.Client()));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieDetailsBloc(
            movieRepository: movieRepository,
          ),
        ),
        BlocProvider(
          create: (context) => CastBloc(
            movieRepository: movieRepository,
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xff0e0e0e),
        body: _buildMovieDetails(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }

  _buildMovieDetails() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsInitial) {
          BlocProvider.of<MovieDetailsBloc>(context)
              .add(FetchMovieDetails(id: data));
        }

        if (state is MovieDetailsError) {
          return Center(
            child: Text('There was a problem'),
          );
        }

        if (state is MovieDetailsLoaded) {
          MovieDetails movieDetails = state.movieDetails;
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 1,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://image.tmdb.org/t/p/w500${movieDetails.poster_path}',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movieDetails.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.red,
                                size: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                movieDetails.release_date,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.thumb_up,
                                color: Colors.red,
                                size: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                movieDetails.popularity.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                movieDetails.vote_average.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.timelapse,
                                color: Colors.red,
                                size: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                movieDetails.runtime.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movieDetails.overview,
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.3,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Genres',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 20,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movieDetails.genres.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              movieDetails.genres[i].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Cast',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    _buildCast(),
                  ],
                ),
              )
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildCast() {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastInitial) {
          BlocProvider.of<CastBloc>(context).add(FetchCast(id: data));
        }

        if (state is CastLoading) {
          return CircularProgressIndicator();
        }

        if (state is CastLoaded) {
          return Container(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.cast.length,
              itemBuilder: (context, i) {
                return Container(
                  height: double.infinity,
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: state.cast[i].profile_path != null
                            ? NetworkImage(
                                'https://image.tmdb.org/t/p/w500${state.cast[i].profile_path}')
                            : AssetImage(
                                'assets/images/actor.png',
                              ),
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black26,
                        fit: BoxFit.fitHeight,
                        colorBlendMode: BlendMode.darken,
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: Text(
                          state.cast[i].name,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
