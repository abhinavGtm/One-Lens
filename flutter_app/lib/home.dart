import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
class HomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  String directory='';
  List file = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    directory = (await getExternalStorageDirectory())!.path;
    setState(() {
      file = io.Directory("$directory/").listSync();  //use your folder name insted of resume.
    });
  }

  // Build Part
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE3790A),
        title: Text(' Home',style: GoogleFonts.poppins(fontSize: 24),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // your Content if there
            Expanded(
              child: ListView.builder(
                  itemCount: file.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children:  [
                            Expanded(
                              flex:1,
                              child: Column(
                                children: [
                                  Icon(Icons.picture_as_pdf_outlined,size: 150,color: Color(0xFFE3790A),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(basename(file[index].path),style: GoogleFonts.poppins(fontSize: 16,color: Colors.black),),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        Share.shareFiles([file[index].path], text: 'Created Using OneLens');
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.share,color: const Color(0xFFE3790A),),
                                          Text('  Share',style: GoogleFonts.poppins(fontSize: 16,),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        OpenFile.open(file[index].path);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.open_in_new_outlined,color: const Color(0xFFE3790A),),
                                          Text('  Open File',style: GoogleFonts.poppins(fontSize: 16,),),
                                        ],
                                      ),
                                    ),
                                  ),Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async{
                                        await file[index].delete();
                                        file.removeAt(index);
                                        setState(() {

                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete,color: const Color(0xFFE3790A),),
                                          Text('  Delete File',style: GoogleFonts.poppins(fontSize: 16,),),
                                        ],
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}