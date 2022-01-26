import 'package:flutter/material.dart';
import 'camera.dart';
class Home extends StatefulWidget {
const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex =0;
  final List<Widget> _pages=[

    Camera(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scanner),
            label: 'PDF Scanner',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
