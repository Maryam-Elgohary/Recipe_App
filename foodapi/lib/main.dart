import 'package:flutter/material.dart';
import 'package:foodapi/favourite.dart';
import 'package:foodapi/helper.dart';
import 'package:foodapi/home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RecipeHelper.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selsctedIndex = 0;
  PageController pageController = PageController();
  static List<Widget> screens = <Widget>[
    HomeScreen(),
    FavoriteRecipesScreen(),
  ];

  void onTapped(int index) {
    setState(() {
      _selsctedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selsctedIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selsctedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black26,
        onTap: onTapped,
      ),
    );
  }
}
