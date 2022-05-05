import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'get_data.dart';
import 'package:share/share.dart';
import 'handle_location.dart';
import 'my_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:path/path.dart' as Path;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'pdf_preview_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'get_data.dart';

final _firestore = Firestore.instance;
final pdf = pw.Document();

class ShowResults extends StatefulWidget {
  ShowResults({this.image, this.outputs});
  final outputs;
  final File image;
  Map body;

  @override
  _ShowResultsState createState() => _ShowResultsState();
}

class _ShowResultsState extends State<ShowResults> {
  String keyword;
  String confidence;
  double lat;
  double long;
  String _uploadedFileURL;
  String error;
  final pdf = pw.Document();

  HandleLocation location;
  @override
  void initState() {
    keyword = widget.outputs[0]["label"].toString().substring(2);
    confidence = widget.outputs[0]["confidence"].toString().substring(0, 5);
  }

  void share(BuildContext context, String text) {
    final RenderBox box = context.findRenderObject();

    Share.share(text,
        subject: "New crop clicked",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Future uploadFile() async {
    try {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('${Path.basename(widget.image.path)}}${DateTime.now()}');
      StorageUploadTask uploadTask = storageReference.putFile(widget.image);
      await uploadTask.onComplete;

      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
          print(_uploadedFileURL);
        });
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Crop Name :$keyword', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'Confidence : $confidence'),
          pw.Paragraph(text: GetData().getData(keyword)),
        ];
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          widget.image == null
              ? Text("Please go back and Select an image")
              : Image.file(widget.image),
          Padding(
            padding: const EdgeInsets.all(0),
          ),
          Container(
            child: widget.outputs != null
                ? Text(
                    "\nLabel:                ${keyword}\nProbability:           ${confidence}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "Unknown error occured, please try again",
                    style: TextStyle(color: Colors.redAccent),
                  ),
            width: 300,
            height: 106,
            decoration: BoxDecoration(
              color: Colors.black,
              border: new Border.all(
                color: Colors.black54,
                width: 2.0,
              ),
              // borderRadius: new BorderRadius.circular(12.0)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black, border: Border.all(color: Colors.white)),
            child: Column(
              children: <Widget>[
                Text(
                  "\nDescription",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                ),
                Text(
                  GetData().getData(keyword),
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      color: Colors.lightGreen,
                      child: Text("Share"),
                      onPressed: () async {
                        location = HandleLocation();
                        await location.getLocation();
                        setState(() {
                          lat = location.latitude;
                          long = location.longitude;
                        });
                        share(context,
                            "Crop: $keyword\nLocation: $lat, $long \n With Probability: $confidence");
                        // String BASE64_IMAGE = Image.file(widget.image).toString();
                        // AdvancedShare.generic(
                        //     msg: "Crop: $keyword\nLocation: $lat, $long \n With Probability: $confidence",
                        //     subject: "New crop identification",
                        //     title: "Share Crop Image",
                        //     url: BASE64_IMAGE
                        //   ).then((response){
                        //   print(response);
                        //   });
                      },
                    ),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(15),
                    //   color: Colors.lightGreen,
                    //   child: Text("See Map"),
                    //   onPressed: () async {
                    //     location = HandleLocation();
                    //     await location.getLocation();
                    //     setState(() {
                    //       lat = location.latitude;
                    //       long = location.longitude;
                    //     });
                    //     ShowMaps map = ShowMaps(
                    //         lat: lat,
                    //         long: long,
                    //         label: keyword,
                    //         description: GetData().getData(keyword));
                    //
                    //     map.showUserMap();
                    //   },
                    // ),
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      color: Colors.lightGreen,
                      child: Text("Save"),
                      onPressed: () async {
                        writeOnPdf();
                        await savePdf();

                        Directory documentDirectory =
                            await getApplicationDocumentsDirectory();

                        String documentPath = documentDirectory.path;

                        String fullPath = "$documentPath/example.pdf";
                        print(fullPath);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfPreviewScreen(
                                      path: fullPath,
                                    )));
                        // location = HandleLocation();
                        // await location.getLocation();
                        //
                        // location.error != null
                        //     ? Alert(
                        //             context: context,
                        //             title: "Error",
                        //             desc:
                        //                 "Error in getting location, try restarting app")
                        //         .show()
                        //     : null;
                        //
                        // setState(() {
                        //   lat = location.latitude;
                        //   long = location.longitude;
                        // });
                        // uploadFile();
                        //
                        // _firestore.collection('crops').add({
                        //   'name': keyword,
                        //   'lat': lat,
                        //   'long': long,
                        //   'image': _uploadedFileURL
                        // });
                        // error != null
                        //     ? Alert(
                        //             context: context,
                        //             title: "Error",
                        //             desc:
                        //                 "Error in getting location, try restarting app")
                        //         .show()
                        //     : Alert(
                        //             context: context,
                        //             title: "Yay",
                        //             desc: "Data uploaded successfuly")
                        //         .show();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
