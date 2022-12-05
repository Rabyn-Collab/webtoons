import 'package:flutter/material.dart';
import 'package:webtoons/route_generator.dart';
import 'package:webtoons/ui/pages/anime_page.dart';
import 'package:webtoons/ui/pages/manga_page.dart';
import 'package:webtoons/utils/boxes.dart';
import 'package:webtoons/utils/theme.dart';

void main() async {
  await Boxes.initializeBoxes();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'webtoons',
      darkTheme: appTheme(),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  final screens = [
     Container(child: Image.network('https://i.pinimg.com/564x/af/3c/bd/af3cbdc3c89041a52a67d6fe07a81710.jpg'),),
    const MangaPage(),
    //const Center(child: Text('Settings')),
  ];

  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: myNavBar(),
    );
  }

  BottomNavigationBar myNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (newIndex) => updateIndex(newIndex),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Manga',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings),
        //   label: 'Settings',
        // ),
      ],
    );
  }
}
