import 'package:flutter/material.dart';
import 'package:qurandaily/screen/bottomnavigation/bottomfavourites.dart';
import 'package:qurandaily/screen/bottomnavigation/bottomhomepage.dart';
import 'package:qurandaily/screen/bottomnavigation/bottomsettings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;
const List<Widget> _pages = <Widget>[
  BottomHomePage(),
  BottomFavourites(),
  BottomSettings(),
  // Camera page
  // Chats page
];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   actions: [
        //     IconButton(
        //       onPressed: () => {},
        //       icon: const Icon(Icons.info_outline_rounded),
        //     ),
        //   ],
        // ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          iconSize: 27,
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          selectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.house_outlined,
                color: Colors.blue,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_outline_outlined,
                color: Colors.blue,
              ),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
