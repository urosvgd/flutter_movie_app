import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_page.dart';

// Repository
import 'package:movies_app/repository/movie_repository.dart';
// BLoC
import "package:bloc/bloc.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/movies/movies_bloc.dart';

// HTTP
import 'package:http/http.dart' as http;
import 'package:movies_app/service/movie_api_client.dart';

// Routes
import './routes.dart';

void main() {
  Bloc.observer = MyBlocDelegate();
  runApp(MyApp());
}

class MyBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  MovieRepository movieRepository = MovieRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark, 
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocProvider(
        create: (context) =>
            MoviesBloc(movieRepository: movieRepository)..add(FetchMovies()),
        child: HomePage(),
      ),
    );
  }
}
