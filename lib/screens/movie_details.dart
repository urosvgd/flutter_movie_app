import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final data;
  const MovieDetails({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: Color(0xff0e0e0e),
      appBar: AppBar(
        title: Text('Routing App'),
        backgroundColor: Color(0xff393E41),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: movieDetail(data),
        ),
      ),
    );
  }

  Column movieDetail(data) {
    return Column(
          children: <Widget>[
            Container(
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/${data.poster_path}",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              data.title,
              style: TextStyle(fontSize: 50),
            ),
            Text(
              data.overview,
              style: TextStyle(fontSize: 20),
            ),
          ],
        );
  }
}
