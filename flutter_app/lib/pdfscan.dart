import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:async';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PDFScan extends StatefulWidget {

  @override
  _PDFScanState createState() => _PDFScanState();
}

enum AppState {
  free,
  cropped,
  done,
}

class _PDFScanState extends State<PDFScan> {
  late AppState state;
  File? imageFile;
  var valueText;
  List<File> _image = [];
  final picker = ImagePicker();
  final pdf = pw.Document();

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE3790A),
        title: Text('PDF Scan',style: GoogleFonts.poppins(fontSize: 24, ),),
      ),
      body: Center(
        child: imageFile != null ? SingleChildScrollView(
          child: Column(
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(10),
                   child: Image.file(imageFile!)),
              ),
              Text('Add Another :',style: GoogleFonts.poppins(fontSize: 16,color: Colors.black),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _image.add(imageFile!);
                      _pickImageg();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF687B87).withOpacity(0.9),
                        ),
                        child: Column(
                          children:[
                            Icon(Icons.image,size: 45,color: Colors.white,),
                            Text('Gallery',style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _image.add(imageFile!);
                      _pickImagec();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF687B87).withOpacity(0.9),
                        ),
                        child: Column(
                          children:[
                            Icon(Icons.camera_alt,size: 45,color: Colors.white,),
                            Text('Camera',style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                color: Color(0xFFE3790A),
                 onPressed: () async {
                _image.add(imageFile!);
                _displayTextInputDialog(context);
              }, child: Text('Done',style: GoogleFonts.poppins(fontSize: 16,),)),
            ],
          ),
        )
            : SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(
                height: 20,
              ),
              Text('Scan From :',style: GoogleFonts.poppins(fontSize: 26,color: Colors.black),),
              GestureDetector(
                onTap: _pickImageg,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF687B87).withOpacity(0.9),
                    ),
                    child: Column(
                      children:[
                        Icon(Icons.image,size: 200,color: Colors.white,),
                        Text('Gallery',style: GoogleFonts.poppins(fontSize: 26,color: Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _pickImagec,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF687B87).withOpacity(0.9),
                    ),
                    child: Column(
                      children:[
                        Icon(Icons.camera_alt,size: 200,color: Colors.white,),
                        Text('Camera',style: GoogleFonts.poppins(fontSize: 26,color: Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
            ),
      ),

    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free) {
      return const Icon(Icons.add);
    }
    else if (state == AppState.cropped) {
      return const Icon(Icons.clear);
    } else {
      return Container();
    }
  }

  Future<void> _pickImagec() async {
    final pickedImage =
    await ImagePicker().getImage(source: ImageSource.camera);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        _cropImage();
      });
    }
  }

  Future<void> _pickImageg() async {
    final pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        _cropImage();
      });
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Filename :'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Filename"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Color(0xFFE3790A),
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    createPDF();
                    savePDF();
                    print(_image);
                    _cancel();
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }
  void _cancel() {
    imageFile = null;
    _image = [];
    setState(() {
      state = AppState.free;
    });
  }

  createPDF() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

  savePDF() async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/$valueText.pdf');
      print(file.path);
      await file.writeAsBytes(await pdf.save());
      showPrintedMessage('success', 'saved to documents');
    } catch (e) {
      print(e);
      showPrintedMessage('error', e.toString());
    }
  }

  showPrintedMessage(String title, String msg) {
    Flushbar(
      title: title,
      message: msg,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.info,
        color: Colors.blue,
      ),
    )
      ..show(context);
  }
}
