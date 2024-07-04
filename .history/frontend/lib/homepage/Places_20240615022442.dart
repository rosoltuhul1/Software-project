import 'package:flutter/material.dart';
import 'package:frontend/screen/FadeAnimation.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/homepage/places_services.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int totalPage = 3;
  late PlacesService _placesService;
  List<dynamic> _places = [];
  bool _isLoading = true;

  void _onScroll() {}

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0)..addListener(_onScroll);
    _placesService = PlacesService();
    _fetchNearbyPlaces();
  }

  void _fetchNearbyPlaces() async {
    try {
      final places = await _placesService.getNearbyPlaces(32.22111, 35.25444); // Example coordinates
      print(places);
      setState(() {
        _places = places;
        totalPage = places.length;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Places,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFffffff)
                            : const Color(0xFF000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      S.of(context).view_all,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFffffff)
                            : const Color(0xFF000000).withOpacity(0.7),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 550, // Adjust this height based on your UI design
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  itemCount: _places.length + 3, // Including 3 hardcoded pages
                  itemBuilder: (context, index) {
                    if (index < 3) {
                      // Hardcoded pages
                      final titles = ['Nablus Old City', 'Bashar Almasri Palace', 'Jamal Abd Alnasser'];
                      final descriptions = [
                        'Nablus old city has many different places with a nice color.',
                        'A palace that is located on the highest point of Nablus.',
                        'Nice park with beautiful nature.'
                      ];
                      final images = ['images/nablus1.jpg', 'images/nablus2.jpg', 'images/nablus3.jpg'];
                      return makeLocalPage(
                        themeProvider: themeProvider,
                        page: index + 1,
                        image: images[index],
                        title: titles[index],
                        description: descriptions[index],
                      );
                    } else {
                      // Pages from API
                      final place = _places[index - 3];
                      return makePage(
                        themeProvider: themeProvider,
                        page: index + 1,
                        image: place['icon'], // Use place['photos'] if available
                        title: place['name'],
                        description: place['vicinity'],
                      );
                    }
                  },
                ),
              ),
            ],
          );
  }

  Widget makeLocalPage({
    required ThemeProvider themeProvider,
    required String image,
    required String title,
    required String description,
    required int page,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            stops: const [0.3, 0.9],
            colors: [
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFFffffff)
                          : const Color(0xFF000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  FadeAnimation(
                    2,
                    Text(
                      page.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '/$totalPage',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              const Spacer(),
              FadeAnimation(
                1,
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      height: 1.2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const FadeAnimation(
                1.5,
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.grey, size: 15),
                    SizedBox(width: 5),
                    Text('4.0', style: TextStyle(color: Colors.white70)),
                    Text('(2300)', style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeAnimation(
                2,
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        height: 1.9,
                        fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const FadeAnimation(
                2.5,
                Text('READ MORE', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget makePage({
    required ThemeProvider themeProvider,
    required String image,
    required String title,
    required String description,
    required int page,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            stops: const [0.3, 0.9],
            colors: [
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFFffffff)
                          : const Color(0xFF000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  FadeAnimation(
                    2,
                    Text(
                      page.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '/$totalPage',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              const Spacer(),
              FadeAnimation(
                1,
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      height: 1.2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const FadeAnimation(
                1.5,
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    Icon(Icons.star, color: Colors.grey, size: 15),
                    SizedBox(width: 5),
                    Text('4.0', style: TextStyle(color: Colors.white70)),
                    Text('(2300)', style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeAnimation(
                2,
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        height: 1.9,
                        fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const FadeAnimation(
                2.5,
                Text('READ MORE', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
