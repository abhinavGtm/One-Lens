import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'function.dart';

class ResultPage extends StatefulWidget
{
  var text;
  ResultPage(this.text);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResultPageState();
  }

}

class ResultPageState extends State<ResultPage> {
  String selectedValue = "hi";

  int state=0;
  String url='';
  var data;
  String output=' ';
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Hindi"),value: "hi"),
      DropdownMenuItem(child: Text("French"),value: "fr"),
      DropdownMenuItem(child: Text("German"),value: "de"),
      DropdownMenuItem(child: Text("Tamil"),value: "ta"),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE3790A),
    title: Text(' Translate Text',style: GoogleFonts.poppins(fontSize: 24),),
    ),
      body: Column(
        children: [
          Text(widget.text),
          Text('Translate To ?'),
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
              url='https://abhijeetgupta.pythonanywhere.com/predict?s=${widget.text}&tar=$selectedValue';
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
        ],
      ),
    ]
    ),
    );
  }
}