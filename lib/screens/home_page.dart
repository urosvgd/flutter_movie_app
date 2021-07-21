import 'package:flutter/material.dart';

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

  PageController pageController = PageController(initialPage: 0);

  int index = 0;
  final scrollThreshold = 200;

  @override
  void initState() {
    super.initState();
    bottomController.addListener(_onScroll);
    // add bloc
  }

  void _onScroll() {
    final maxScroll = bottomController.position.maxScrollExtent;
    final currentScroll = bottomController.position.pixels;

    if (maxScroll - currentScroll <= scrollThreshold) {
      // initialize fetching next page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e0e0e),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
