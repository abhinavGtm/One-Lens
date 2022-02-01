import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/pdfscan.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ocr.dart';
class NavBar extends StatefulWidget {
const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex =0;
  final List<Widget> _pages=[
    HomePage(),
    OCR(),
    PDFScan(),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomNavigationBar(
          borderRadius: Radius.circular(13),
          iconSize: 30.0,
          selectedColor: Color(0xFFE3790A),
          strokeColor: Color(0x30040307),
          unSelectedColor: Colors.white,
          backgroundColor: Color(0xFF687B87).withOpacity(0.9),
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home",style: GoogleFonts.poppins(color: _selectedIndex==0?Color(0xFFE3790A):Colors.white),),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text("Lens",style: GoogleFonts.poppins(color: _selectedIndex==1?Color(0xFFE3790A):Colors.white)),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.scanner),
              title: Text("Scanner",style: GoogleFonts.poppins(color: _selectedIndex==2?Color(0xFFE3790A):Colors.white)),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
