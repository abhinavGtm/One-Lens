import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/function.dart';
import 'package:flutter_app/text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:core';
var text;
var lang;
var value;
var value1;
var token;
var data;
var output=' ';
String selectedValue = "hi";

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Hindi"),value: "hi"),
    DropdownMenuItem(child: Text("French"),value: "fr"),
    DropdownMenuItem(child: Text("German"),value: "de"),
    DropdownMenuItem(child: Text("Tamil"),value: "ta"),
  ];
  return menuItems;
}



class OCR extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OCRState();
  }

}

class OCRState extends State<OCR> {
  var url ='';
  int state=0;
  @override
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE3790A),
        title: Text(' Search / Translate Text',style: GoogleFonts.poppins(fontSize: 24),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  SizedBox(height: 30,),
                  Text("Search Text Or Translate It!",style: GoogleFonts.poppins(color: Colors.black,fontSize: 20),),
                  SizedBox(height: 20,),
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: 'Enter the text',
                    ),
                    controller: myController,
                    onChanged: (value){
                      setState(() {
                        text=value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                      value: selectedValue,
                      onChanged: (String? newValue){
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color:  Color(0xFFE3790A),
                        onPressed: () async{
                        setState(() {
                          state=1;
                        });
                        url='https://abhijeetgupta.pythonanywhere.com/predict?s=$text&tar=$selectedValue';
                        data= await fetchdata(url);
                        var decoded=await jsonDecode(data);
                        print(decoded);
                        setState(() {
                          output= decoded;
                          state=2;
                        });
                      },
                        child: Text(
                            'Translate',style:GoogleFonts.poppins(color: Colors.white,fontSize: 16),
                        ),
                      ),
                      buttonWidget("Search"),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('Result: ',style: GoogleFonts.poppins(color: Colors.black,fontSize: 20),),
                  state==0?Text(' '):Text(state==1?'Loading...':output,style: GoogleFonts.poppins(color: Colors.black,fontSize: 16),),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TextRecognizerView()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFE3790A),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text('Try For Image!', style: GoogleFonts.poppins(color: Colors.white,fontSize: 18,),)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );

  }
}
Widget buttonWidget(String label){
  return ButtonTheme(child: RaisedButton(
    color:  Color(0xFFE3790A),
    child: Text(label,style: GoogleFonts.poppins(color: Colors.white,fontSize: 16),),
    onPressed: _launchURL,
  ),);
}


void _launchURL() async {
  token= text.split('+');
  String _url1 = 'https://www.google.com/search?q=$token';
  if (!await launch(_url1)) throw 'Could not launch $_url1';
}

